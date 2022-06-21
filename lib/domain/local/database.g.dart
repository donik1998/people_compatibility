// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Comparison extends DataClass implements Insertable<Comparison> {
  final String maleName;
  final String femaleName;
  final String responseJson;

  /// [timeStamp] stores last edited date
  final String timeStamp;
  Comparison(
      {required this.maleName,
      required this.femaleName,
      required this.responseJson,
      required this.timeStamp});
  factory Comparison.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Comparison(
      maleName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}male_name'])!,
      femaleName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}female_name'])!,
      responseJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}response_json'])!,
      timeStamp: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time_stamp'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['male_name'] = Variable<String>(maleName);
    map['female_name'] = Variable<String>(femaleName);
    map['response_json'] = Variable<String>(responseJson);
    map['time_stamp'] = Variable<String>(timeStamp);
    return map;
  }

  ComparisonsCompanion toCompanion(bool nullToAbsent) {
    return ComparisonsCompanion(
      maleName: Value(maleName),
      femaleName: Value(femaleName),
      responseJson: Value(responseJson),
      timeStamp: Value(timeStamp),
    );
  }

  factory Comparison.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Comparison(
      maleName: serializer.fromJson<String>(json['maleName']),
      femaleName: serializer.fromJson<String>(json['femaleName']),
      responseJson: serializer.fromJson<String>(json['responseJson']),
      timeStamp: serializer.fromJson<String>(json['timeStamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'maleName': serializer.toJson<String>(maleName),
      'femaleName': serializer.toJson<String>(femaleName),
      'responseJson': serializer.toJson<String>(responseJson),
      'timeStamp': serializer.toJson<String>(timeStamp),
    };
  }

  Comparison copyWith(
          {String? maleName,
          String? femaleName,
          String? responseJson,
          String? timeStamp}) =>
      Comparison(
        maleName: maleName ?? this.maleName,
        femaleName: femaleName ?? this.femaleName,
        responseJson: responseJson ?? this.responseJson,
        timeStamp: timeStamp ?? this.timeStamp,
      );
  @override
  String toString() {
    return (StringBuffer('Comparison(')
          ..write('maleName: $maleName, ')
          ..write('femaleName: $femaleName, ')
          ..write('responseJson: $responseJson, ')
          ..write('timeStamp: $timeStamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(maleName, femaleName, responseJson, timeStamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Comparison &&
          other.maleName == this.maleName &&
          other.femaleName == this.femaleName &&
          other.responseJson == this.responseJson &&
          other.timeStamp == this.timeStamp);
}

class ComparisonsCompanion extends UpdateCompanion<Comparison> {
  final Value<String> maleName;
  final Value<String> femaleName;
  final Value<String> responseJson;
  final Value<String> timeStamp;
  const ComparisonsCompanion({
    this.maleName = const Value.absent(),
    this.femaleName = const Value.absent(),
    this.responseJson = const Value.absent(),
    this.timeStamp = const Value.absent(),
  });
  ComparisonsCompanion.insert({
    required String maleName,
    required String femaleName,
    required String responseJson,
    required String timeStamp,
  })  : maleName = Value(maleName),
        femaleName = Value(femaleName),
        responseJson = Value(responseJson),
        timeStamp = Value(timeStamp);
  static Insertable<Comparison> custom({
    Expression<String>? maleName,
    Expression<String>? femaleName,
    Expression<String>? responseJson,
    Expression<String>? timeStamp,
  }) {
    return RawValuesInsertable({
      if (maleName != null) 'male_name': maleName,
      if (femaleName != null) 'female_name': femaleName,
      if (responseJson != null) 'response_json': responseJson,
      if (timeStamp != null) 'time_stamp': timeStamp,
    });
  }

  ComparisonsCompanion copyWith(
      {Value<String>? maleName,
      Value<String>? femaleName,
      Value<String>? responseJson,
      Value<String>? timeStamp}) {
    return ComparisonsCompanion(
      maleName: maleName ?? this.maleName,
      femaleName: femaleName ?? this.femaleName,
      responseJson: responseJson ?? this.responseJson,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (maleName.present) {
      map['male_name'] = Variable<String>(maleName.value);
    }
    if (femaleName.present) {
      map['female_name'] = Variable<String>(femaleName.value);
    }
    if (responseJson.present) {
      map['response_json'] = Variable<String>(responseJson.value);
    }
    if (timeStamp.present) {
      map['time_stamp'] = Variable<String>(timeStamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComparisonsCompanion(')
          ..write('maleName: $maleName, ')
          ..write('femaleName: $femaleName, ')
          ..write('responseJson: $responseJson, ')
          ..write('timeStamp: $timeStamp')
          ..write(')'))
        .toString();
  }
}

class $ComparisonsTable extends Comparisons
    with TableInfo<$ComparisonsTable, Comparison> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComparisonsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _maleNameMeta = const VerificationMeta('maleName');
  @override
  late final GeneratedColumn<String?> maleName = GeneratedColumn<String?>(
      'male_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _femaleNameMeta = const VerificationMeta('femaleName');
  @override
  late final GeneratedColumn<String?> femaleName = GeneratedColumn<String?>(
      'female_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _responseJsonMeta =
      const VerificationMeta('responseJson');
  @override
  late final GeneratedColumn<String?> responseJson = GeneratedColumn<String?>(
      'response_json', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _timeStampMeta = const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<String?> timeStamp = GeneratedColumn<String?>(
      'time_stamp', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [maleName, femaleName, responseJson, timeStamp];
  @override
  String get aliasedName => _alias ?? 'comparisons';
  @override
  String get actualTableName => 'comparisons';
  @override
  VerificationContext validateIntegrity(Insertable<Comparison> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('male_name')) {
      context.handle(_maleNameMeta,
          maleName.isAcceptableOrUnknown(data['male_name']!, _maleNameMeta));
    } else if (isInserting) {
      context.missing(_maleNameMeta);
    }
    if (data.containsKey('female_name')) {
      context.handle(
          _femaleNameMeta,
          femaleName.isAcceptableOrUnknown(
              data['female_name']!, _femaleNameMeta));
    } else if (isInserting) {
      context.missing(_femaleNameMeta);
    }
    if (data.containsKey('response_json')) {
      context.handle(
          _responseJsonMeta,
          responseJson.isAcceptableOrUnknown(
              data['response_json']!, _responseJsonMeta));
    } else if (isInserting) {
      context.missing(_responseJsonMeta);
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    } else if (isInserting) {
      context.missing(_timeStampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Comparison map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Comparison.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ComparisonsTable createAlias(String alias) {
    return $ComparisonsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ComparisonsTable comparisons = $ComparisonsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [comparisons];
}
