import 'dart:convert';

import 'package:people_compatibility/core/models/comparison.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/domain/local/database.dart';

abstract class DatabaseRepository {
  Future<void> saveData({
    required String maleName,
    required String femaleName,
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
              femaleName: e.femaleName,
              maleName: e.maleName,
              date: DateTime.parse(e.timeStamp),
              result: CompatibilityResponse.fromJson(jsonDecode(e.responseJson)),
            ))
        .toList();
  }

  @override
  Future<void> saveData({
    required String maleName,
    required String femaleName,
    required DateTime date,
    required CompatibilityResponse response,
  }) async {
    await AppDatabase.instance.addComparison(
      Comparison(
        maleName: maleName,
        femaleName: femaleName,
        responseJson: jsonEncode(response.toJson()),
        timeStamp: DateTime.now().toIso8601String(),
      ),
    );
  }
}
