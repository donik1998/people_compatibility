import 'package:dio/dio.dart';
import 'package:people_compatibility/core/models/city_search_response.dart';
import 'package:people_compatibility/presentation/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'https://maps.googleapis.com/maps/api/place')
abstract class ApiClient {
  static ApiClient get instance => _ApiClient(_dio);

  static final Dio _dio = Dio()
    ..interceptors.add(LogInterceptor(responseBody: true))
    ..options = BaseOptions(
      queryParameters: {'key': Constants.googlePlacesApiKey},
    );

  @GET('/queryautocomplete/json')
  Future<CitySearchResponse> getPlaceByInput(
    @Query('input') String input,
    @Query('language') String lang,
    @Query('types') String type,
  );
}
