import 'package:people_compatibility/core/models/person_details.dart';

class CompatibilityData {
  final PersonDetails female;
  final PersonDetails male;
  final DateTime date;

  CompatibilityData({
    required this.female,
    required this.male,
    required this.date,
  });

  factory CompatibilityData.fromJson(Map<String, dynamic> json) => CompatibilityData(
        female: PersonDetails.fromJson(json['female']),
        male: PersonDetails.fromJson(json['male']),
        date: DateTime.parse(json['date']),
      );

  Map<String, dynamic> get toMap => {
        'female_name': female.asMap,
        'male_name': male.asMap,
        'date': date.toIso8601String(),
      };
}
