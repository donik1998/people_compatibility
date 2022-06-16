// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _GooglePlacesApiClient implements GooglePlacesApiClient {
  _GooglePlacesApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://maps.googleapis.com/maps/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CitySearchResponse> getPlaceByInput(input, lang, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'input': input,
      r'language': lang,
      r'types': type
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CitySearchResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/place/queryautocomplete/json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CitySearchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CityGeocodeResponse> getCityLocation(placeId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'place_id': placeId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CityGeocodeResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/geocode/json',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CityGeocodeResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
