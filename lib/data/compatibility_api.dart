import 'package:dio/dio.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/data/uri_interceptor.dart';
import 'package:people_compatibility/presentation/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'compatibility_api.g.dart';

@RestApi(baseUrl: 'https://uhnem.com')
abstract class PeopleCompatibilityApiClient {
  static PeopleCompatibilityApiClient get instance => _PeopleCompatibilityApiClient(_dio);

  static final Dio _dio = Dio()
    ..interceptors.addAll([
      LogInterceptor(responseBody: true),
      UriInterceptor(),
    ])
    ..options = BaseOptions(
      queryParameters: {'key': Constants.peopleCompatibilityApiKey},
    );

  @GET('/api/')
  Future<CompatibilityResponse> getPlaceByInput(
    @Query('sex1') String firstGender,
    @Query('sex2') String secondGender,
    @Query('day1') int firstGenderDayOfBirth,
    @Query('day2') int secondGenderDayOfBirth,
    @Query('month1') int firstGenderMonthOfBirth,
    @Query('month2') int secondGenderMonthOfBirth,
    @Query('year1') int firstGenderYearOfBirth,
    @Query('year2') int secondGenderYearOfBirth,
    @Query('hour1') int? firstGenderHourOfBirth,
    @Query('hour2') int? secondGenderHourOfBirth,
    @Query('minute1') int? firstGenderMinuteOfBirth,
    @Query('minute2') int? secondGenderMinuteOfBirth,
    @Query('notime1') int firstGenderBirthTimeUnknown,
    @Query('notime2') int secondGenderBirthTimeUnknown,
    @Query('name1') String firstGenderName,
    @Query('name2') String secondGenderName,
    @Query('long1') double firstGenderCityLon,
    @Query('long2') double secondGenderCityLon,
    @Query('lat1') double firstGenderCityLat,
    @Query('lat2') double secondGenderCityLat,
  );
}
