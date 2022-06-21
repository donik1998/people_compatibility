import 'package:dio/dio.dart';
import 'package:people_compatibility/core/models/city_geocode_response.dart';
import 'package:people_compatibility/core/models/city_search_response.dart';
import 'package:people_compatibility/presentation/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'places_api.g.dart';

@RestApi(baseUrl: 'https://maps.googleapis.com/maps/api')
abstract class GooglePlacesApiClient {
  static GooglePlacesApiClient get instance => _GooglePlacesApiClient(_dio);

  static final Dio _dio = Dio()
    ..interceptors.add(LogInterceptor(responseBody: true))
    ..options = BaseOptions(
      queryParameters: {'key': Constants.googlePlacesApiKey},
    );

  @GET('/place/queryautocomplete/json')
  Future<PlaceSearchResponse> getPlaceByInput(
    @Query('input') String input,
    @Query('language') String lang,
    @Query('types') String type,
  );

  @GET('/geocode/json')
  Future<CityGeocodeResponse> getCityLocation(
    @Query('place_id') String placeId,
  );
}
