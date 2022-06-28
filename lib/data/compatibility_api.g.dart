// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compatibility_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _PeopleCompatibilityApiClient implements PeopleCompatibilityApiClient {
  _PeopleCompatibilityApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://siastro.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CompatibilityResponse> getPlaceByInput(
      firstGender,
      secondGender,
      firstGenderDayOfBirth,
      secondGenderDayOfBirth,
      firstGenderMonthOfBirth,
      secondGenderMonthOfBirth,
      firstGenderYearOfBirth,
      secondGenderYearOfBirth,
      firstGenderHourOfBirth,
      secondGenderHourOfBirth,
      firstGenderMinuteOfBirth,
      secondGenderMinuteOfBirth,
      firstGenderBirthTimeUnknown,
      secondGenderBirthTimeUnknown,
      firstGenderName,
      secondGenderName,
      firstGenderCityLon,
      secondGenderCityLon,
      firstGenderCityLat,
      secondGenderCityLat) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sex1': firstGender,
      r'sex2': secondGender,
      r'day1': firstGenderDayOfBirth,
      r'day2': secondGenderDayOfBirth,
      r'month1': firstGenderMonthOfBirth,
      r'month2': secondGenderMonthOfBirth,
      r'year1': firstGenderYearOfBirth,
      r'year2': secondGenderYearOfBirth,
      r'hour1': firstGenderHourOfBirth,
      r'hour2': secondGenderHourOfBirth,
      r'minute1': firstGenderMinuteOfBirth,
      r'minute2': secondGenderMinuteOfBirth,
      r'notime1': firstGenderBirthTimeUnknown,
      r'notime2': secondGenderBirthTimeUnknown,
      r'name1': firstGenderName,
      r'name2': secondGenderName,
      r'long1': firstGenderCityLon,
      r'long2': secondGenderCityLon,
      r'lat1': firstGenderCityLat,
      r'lat2': secondGenderCityLat
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CompatibilityResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CompatibilityResponse.fromJson(_result.data!);
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
