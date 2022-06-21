import 'package:people_compatibility/core/models/compatibility_response.dart';

class CompatibilityData {
  final String femaleName;
  final String maleName;
  final DateTime date;
  final CompatibilityResponse result;

  CompatibilityData({
    required this.femaleName,
    required this.maleName,
    required this.date,
    required this.result,
  });

  factory CompatibilityData.fromJson(Map<String, dynamic> json) => CompatibilityData(
        femaleName: json['female_name'],
        maleName: json['male_name'],
        date: DateTime.parse(json['date']),
        result: CompatibilityResponse.fromJson(json['result']),
      );

  Map<String, dynamic> get toMap => {
        'female_name': femaleName,
        'male_name': maleName,
        'date': date.toIso8601String(),
        'result': result.toJson(),
      };
}
