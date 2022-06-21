// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Comparison extends DataClass implements Insertable<Comparison> {
  final String male;
  final String female;
  final String responseJson;

  /// [timeStamp] stores last edited date
  final String timeStamp;
  Comparison(
      {required this.male,
      required this.female,
      required this.responseJson,
      required this.timeStamp});
  factory Comparison.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Comparison(
      male: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}male'])!,
      female: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}female'])!,
      responseJson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}response_json'])!,
      timeStamp: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time_stamp'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['male'] = Variable<String>(male);
    map['female'] = Variable<String>(female);
    map['response_json'] = Variable<String>(responseJson);
    map['time_stamp'] = Variable<String>(timeStamp);
    return map;
  }

  ComparisonsCompanion toCompanion(bool nullToAbsent) {
    return ComparisonsCompanion(
      male: Value(male),
      female: Value(female),
      responseJson: Value(responseJson),
      timeStamp: Value(timeStamp),
    );
  }

  factory Comparison.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Comparison(
      male: serializer.fromJson<String>(json['male']),
      female: serializer.fromJson<String>(json['female']),
      responseJson: serializer.fromJson<String>(json['responseJson']),
      timeStamp: serializer.fromJson<String>(json['timeStamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'male': serializer.toJson<String>(male),
      'female': serializer.toJson<String>(female),
      'responseJson': serializer.toJson<String>(responseJson),
      'timeStamp': serializer.toJson<String>(timeStamp),
    };
  }

  Comparison copyWith(
          {String? male,
          String? female,
          String? responseJson,
          String? timeStamp}) =>
      Comparison(
        male: male ?? this.male,
        female: female ?? this.female,
        responseJson: responseJson ?? this.responseJson,
        timeStamp: timeStamp ?? this.timeStamp,
      );
  @override
  String toString() {
    return (StringBuffer('Comparison(')
          ..write('male: $male, ')
          ..write('female: $female, ')
          ..write('responseJson: $responseJson, ')
          ..write('timeStamp: $timeStamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(male, female, responseJson, timeStamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Comparison &&
          other.male == this.male &&
          other.female == this.female &&
          other.responseJson == this.responseJson &&
          other.timeStamp == this.timeStamp);
}

class ComparisonsCompanion extends UpdateCompanion<Comparison> {
  final Value<String> male;
  final Value<String> female;
  final Value<String> responseJson;
  final Value<String> timeStamp;
  const ComparisonsCompanion({
    this.male = const Value.absent(),
    this.female = const Value.absent(),
    this.responseJson = const Value.absent(),
    this.timeStamp = const Value.absent(),
  });
  ComparisonsCompanion.insert({
    required String male,
    required String female,
    required String responseJson,
    required String timeStamp,
  })  : male = Value(male),
        female = Value(female),
        responseJson = Value(responseJson),
        timeStamp = Value(timeStamp);
  static Insertable<Comparison> custom({
    Expression<String>? male,
    Expression<String>? female,
    Expression<String>? responseJson,
    Expression<String>? timeStamp,
  }) {
    return RawValuesInsertable({
      if (male != null) 'male': male,
      if (female != null) 'female': female,
      if (responseJson != null) 'response_json': responseJson,
      if (timeStamp != null) 'time_stamp': timeStamp,
    });
  }

  ComparisonsCompanion copyWith(
      {Value<String>? male,
      Value<String>? female,
      Value<String>? responseJson,
      Value<String>? timeStamp}) {
    return ComparisonsCompanion(
      male: male ?? this.male,
      female: female ?? this.female,
      responseJson: responseJson ?? this.responseJson,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (male.present) {
      map['male'] = Variable<String>(male.value);
    }
    if (female.present) {
      map['female'] = Variable<String>(female.value);
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
          ..write('male: $male, ')
          ..write('female: $female, ')
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
  final VerificationMeta _maleMeta = const VerificationMeta('male');
  @override
  late final GeneratedColumn<String?> male = GeneratedColumn<String?>(
      'male', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _femaleMeta = const VerificationMeta('female');
  @override
  late final GeneratedColumn<String?> female = GeneratedColumn<String?>(
      'female', aliasedName, false,
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
  List<GeneratedColumn> get $columns => [male, female, responseJson, timeStamp];
  @override
  String get aliasedName => _alias ?? 'comparisons';
  @override
  String get actualTableName => 'comparisons';
  @override
  VerificationContext validateIntegrity(Insertable<Comparison> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('male')) {
      context.handle(
          _maleMeta, male.isAcceptableOrUnknown(data['male']!, _maleMeta));
    } else if (isInserting) {
      context.missing(_maleMeta);
    }
    if (data.containsKey('female')) {
      context.handle(_femaleMeta,
          female.isAcceptableOrUnknown(data['female']!, _femaleMeta));
    } else if (isInserting) {
      context.missing(_femaleMeta);
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
