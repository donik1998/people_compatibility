import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Comparisons extends Table {
  TextColumn get maleName => text()();
  TextColumn get femaleName => text()();
  TextColumn get responseJson => text()();

  /// [timeStamp] stores last edited date
  TextColumn get timeStamp => text()();
}

@UseMoor(tables: [Comparisons])
class AppDatabase extends _$AppDatabase {
  static AppDatabase instance = AppDatabase._();

  AppDatabase._() : super(FlutterQueryExecutor.inDatabaseFolder(path: "compatibility.sqlite", logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<void> addComparison(Comparison comparison) => into(comparisons).insert(comparison);
  Future<List<Comparison>> getComparisons() => select(comparisons).get();
}
