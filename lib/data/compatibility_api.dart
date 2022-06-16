import 'package:dio/dio.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/presentation/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'compatibility_api.g.dart';

@RestApi(baseUrl: 'https://uhnem.com')
abstract class PeopleCompatibilityApiClient {
  static PeopleCompatibilityApiClient get instance => _PeopleCompatibilityApiClient(_dio);

  static final Dio _dio = Dio()
    ..interceptors.add(LogInterceptor(responseBody: true))
    ..options = BaseOptions(
      queryParameters: {'key': Constants.peopleCompatibilityApiKey},
    );

  @GET('/api/')
  Future<CompatibilityResponse> getPlaceByInput(
    @Query('sex1') String firstGender,
    @Query('sex2') String secondGender,
    @Query('day1') String firstGenderDayOfBirth,
    @Query('day2') String secondGenderDayOfBirth,
    @Query('month1') String firstGenderMonthOfBirth,
    @Query('month2') String secondGenderMonthOfBirth,
    @Query('year1') String firstGenderYearOfBirth,
    @Query('year2') String secondGenderYearOfBirth,
    @Query('hour1') String firstGenderHourOfBirth,
    @Query('hour2') String secondGenderHourOfBirth,
    @Query('minute1') String firstGenderMinuteOfBirth,
    @Query('minute2') String secondGenderMinuteOfBirth,
    @Query('notime1') bool firstGenderBirthTimeUnknown,
    @Query('notime2') bool secondGenderBirthTimeUnknown,
    @Query('name1') String firstGenderName,
    @Query('name2') String secondGenderName,
    @Query('long1') double firstGenderCityLon,
    @Query('long2') double secondGenderCityLon,
    @Query('lat1') double firstGenderCityLat,
    @Query('lat2') double secondGenderCityLat,
  );
}
