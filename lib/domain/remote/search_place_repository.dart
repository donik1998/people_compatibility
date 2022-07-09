import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:people_compatibility/core/models/city_geocode_response.dart';
import 'package:people_compatibility/core/models/city_search_response.dart';
import 'package:people_compatibility/core/models/place_details.dart';
import 'package:people_compatibility/core/models/place_search_response.dart';
import 'package:people_compatibility/data/failure.dart';
import 'package:people_compatibility/data/places_api.dart';

abstract class SearchPlaceRepository {
  Future<Either<Failure, PlaceSearchResponse>> searchPlaceByInput({
    required String input,
    String lang = 'ru',
    required String type,
  });
  Future<Either<Failure, CityGeocodeResponse>> getCityLocationById(String placeId);
  Future<Either<Failure, PlaceDetails>> getPlaceDetails({
    required String placeId,
    required String lang,
  });
  Future<Either<Failure, CitySearchResponse>> getCityWithinCountry({
    required String lang,
    required String countryCode,
    required String input,
  });
}

class SearchPlaceService implements SearchPlaceRepository {
  SearchPlaceService._();

  static SearchPlaceService get instance => SearchPlaceService._();

  @override
  Future<Either<Failure, PlaceSearchResponse>> searchPlaceByInput({
    required String input,
    String lang = 'ru',
    required String type,
  }) async {
    return await Task<PlaceSearchResponse>(
      () => GooglePlacesApiClient.instance.getPlaceByInput(input, lang, type),
    )
        .attempt()
        .map((either) => either.leftMap((err) {
              Failure failure = Failure(message: 'request_error'.tr());
              if (err is DioError) failure = Failure(message: err.message);
              return failure;
            }))
        .run();
  }

  @override
  Future<Either<Failure, CityGeocodeResponse>> getCityLocationById(String placeId) async {
    return await Task<CityGeocodeResponse>(() => GooglePlacesApiClient.instance.getCityLocation(placeId))
        .attempt()
        .map((either) => either.leftMap((err) {
              Failure failure = Failure(message: 'request_error'.tr());
              if (err is DioError) failure = Failure(message: err.message);
              return failure;
            }))
        .run();
  }

  @override
  Future<Either<Failure, PlaceDetails>> getPlaceDetails({
    required String placeId,
    required String lang,
  }) async {
    return await Task<PlaceDetails>(() => GooglePlacesApiClient.instance.getPlaceDetailsById(placeId, lang))
        .attempt()
        .map((either) => either.leftMap((err) {
              Failure failure = Failure(message: 'request_error'.tr());
              if (err is DioError) failure = Failure(message: err.message);
              return failure;
            }))
        .run();
  }

  @override
  Future<Either<Failure, CitySearchResponse>> getCityWithinCountry({
    required String countryCode,
    required String input,
    required String lang,
  }) async {
    return await Task<CitySearchResponse>(() => GooglePlacesApiClient.instance.getCityOfCountry(input, countryCode, 'locality', lang))
        .attempt()
        .map((either) => either.leftMap((err) {
              Failure failure = Failure(message: 'request_error'.tr());
              if (err is DioError) failure = Failure(message: err.message);
              return failure;
            }))
        .run();
  }
}
