import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/data/compatibility_api.dart';
import 'package:people_compatibility/data/failure.dart';

abstract class PeopleCompatibilityRepository {
  Future<Either<Failure, CompatibilityResponse>> getCompatibility(PersonDetails male, PersonDetails female);
}

class PeopleCompatibilityService implements PeopleCompatibilityRepository {
  PeopleCompatibilityService._();

  static PeopleCompatibilityService get instance => PeopleCompatibilityService._();

  @override
  Future<Either<Failure, CompatibilityResponse>> getCompatibility(PersonDetails male, PersonDetails female) async {
    return await Task<CompatibilityResponse>(() => PeopleCompatibilityApiClient.instance.getPlaceByInput(
              'M',
              'F',
              male.dateOfBirth.day,
              female.dateOfBirth.day,
              male.dateOfBirth.month,
              female.dateOfBirth.month,
              male.dateOfBirth.year,
              female.dateOfBirth.year,
              male.exactTimeUnknown ? null : male.dateOfBirth.hour,
              female.exactTimeUnknown ? null : female.dateOfBirth.hour,
              male.exactTimeUnknown ? null : male.dateOfBirth.minute,
              female.exactTimeUnknown ? null : female.dateOfBirth.minute,
              male.exactTimeUnknown ? 1 : 0,
              female.exactTimeUnknown ? 1 : 0,
              male.name,
              female.name,
              male.city.lon,
              female.city.lon,
              male.city.lat,
              female.city.lat,
            ))
        .attempt()
        .map((a) => a.leftMap((err) {
              Failure failure = Failure(message: 'Ошибка запроса');
              if (err is DioError) {
                failure = Failure(message: err.message);
              }
              return failure;
            }))
        .run();
  }
}
