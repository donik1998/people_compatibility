import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:people_compatibility/core/models/city_search_response.dart';
import 'package:people_compatibility/data/api.dart';
import 'package:people_compatibility/data/failure.dart';

abstract class SearchPlaceRepository {
  Future<Either<Failure, CitySearchResponse>> searchPlaceByInput({
    required String input,
    String lang = 'ru',
    required String type,
  });
}

class SearchPlaceService implements SearchPlaceRepository {
  SearchPlaceService._();

  static SearchPlaceService get instance => SearchPlaceService._();

  @override
  Future<Either<Failure, CitySearchResponse>> searchPlaceByInput({
    required String input,
    String lang = 'ru',
    required String type,
  }) async {
    return await Task<CitySearchResponse>(
      () => ApiClient.instance.getPlaceByInput(input, lang, type),
    )
        .attempt()
        .map((either) => either.leftMap((err) {
              Failure failure = Failure(message: 'Ошибка запроса');
              if (err is DioError) failure = Failure(message: err.message);
              return failure;
            }))
        .run();
  }
}
