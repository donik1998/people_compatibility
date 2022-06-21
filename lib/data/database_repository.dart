import 'dart:convert';

import 'package:people_compatibility/core/models/comparison.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/domain/local/database.dart';

abstract class DatabaseRepository {
  Future<void> saveData({
    required PersonDetails maleName,
    required PersonDetails femaleName,
    required DateTime date,
    required CompatibilityResponse response,
  });
  Future<List<CompatibilityData>> getComparisons();
}

class DatabaseService implements DatabaseRepository {
  DatabaseService._();

  static DatabaseService get instance => DatabaseService._();

  @override
  Future<List<CompatibilityData>> getComparisons() async {
    final comparisons = await AppDatabase.instance.getComparisons();
    return comparisons
        .map((e) => CompatibilityData(
              female: PersonDetails.fromJson(jsonDecode(e.female)),
              male: PersonDetails.fromJson(jsonDecode(e.male)),
              date: DateTime.parse(e.timeStamp),
            ))
        .toList();
  }

  @override
  Future<void> saveData({
    required PersonDetails maleName,
    required PersonDetails femaleName,
    required DateTime date,
    required CompatibilityResponse response,
  }) async {
    await AppDatabase.instance.addComparison(
      Comparison(
        male: jsonEncode(maleName.asMap),
        female: jsonEncode(femaleName.asMap),
        responseJson: jsonEncode(response.toJson()),
        timeStamp: DateTime.now().toIso8601String(),
      ),
    );
  }
}
