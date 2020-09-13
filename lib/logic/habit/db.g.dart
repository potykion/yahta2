// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class HabitDB extends DataClass implements Insertable<HabitDB> {
  final int id;
  final String title;
  final int order;
  final int frequency;
  final int periodValue;
  final PeriodType periodType;
  final Weekday weekStart;
  HabitDB(
      {@required this.id,
      @required this.title,
      @required this.order,
      @required this.frequency,
      @required this.periodValue,
      @required this.periodType,
      @required this.weekStart});
  factory HabitDB.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return HabitDB(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      order: intType.mapFromDatabaseResponse(data['${effectivePrefix}order']),
      frequency:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}frequency']),
      periodValue: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}period_value']),
      periodType: $HabitDBsTable.$converter0.mapToDart(intType
          .mapFromDatabaseResponse(data['${effectivePrefix}period_type'])),
      weekStart: $HabitDBsTable.$converter1.mapToDart(intType
          .mapFromDatabaseResponse(data['${effectivePrefix}week_start'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    if (!nullToAbsent || frequency != null) {
      map['frequency'] = Variable<int>(frequency);
    }
    if (!nullToAbsent || periodValue != null) {
      map['period_value'] = Variable<int>(periodValue);
    }
    if (!nullToAbsent || periodType != null) {
      final converter = $HabitDBsTable.$converter0;
      map['period_type'] = Variable<int>(converter.mapToSql(periodType));
    }
    if (!nullToAbsent || weekStart != null) {
      final converter = $HabitDBsTable.$converter1;
      map['week_start'] = Variable<int>(converter.mapToSql(weekStart));
    }
    return map;
  }

  HabitDBsCompanion toCompanion(bool nullToAbsent) {
    return HabitDBsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      order:
          order == null && nullToAbsent ? const Value.absent() : Value(order),
      frequency: frequency == null && nullToAbsent
          ? const Value.absent()
          : Value(frequency),
      periodValue: periodValue == null && nullToAbsent
          ? const Value.absent()
          : Value(periodValue),
      periodType: periodType == null && nullToAbsent
          ? const Value.absent()
          : Value(periodType),
      weekStart: weekStart == null && nullToAbsent
          ? const Value.absent()
          : Value(weekStart),
    );
  }

  factory HabitDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HabitDB(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      order: serializer.fromJson<int>(json['order']),
      frequency: serializer.fromJson<int>(json['frequency']),
      periodValue: serializer.fromJson<int>(json['periodValue']),
      periodType: serializer.fromJson<PeriodType>(json['periodType']),
      weekStart: serializer.fromJson<Weekday>(json['weekStart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'order': serializer.toJson<int>(order),
      'frequency': serializer.toJson<int>(frequency),
      'periodValue': serializer.toJson<int>(periodValue),
      'periodType': serializer.toJson<PeriodType>(periodType),
      'weekStart': serializer.toJson<Weekday>(weekStart),
    };
  }

  HabitDB copyWith(
          {int id,
          String title,
          int order,
          int frequency,
          int periodValue,
          PeriodType periodType,
          Weekday weekStart}) =>
      HabitDB(
        id: id ?? this.id,
        title: title ?? this.title,
        order: order ?? this.order,
        frequency: frequency ?? this.frequency,
        periodValue: periodValue ?? this.periodValue,
        periodType: periodType ?? this.periodType,
        weekStart: weekStart ?? this.weekStart,
      );
  @override
  String toString() {
    return (StringBuffer('HabitDB(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('order: $order, ')
          ..write('frequency: $frequency, ')
          ..write('periodValue: $periodValue, ')
          ..write('periodType: $periodType, ')
          ..write('weekStart: $weekStart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              order.hashCode,
              $mrjc(
                  frequency.hashCode,
                  $mrjc(periodValue.hashCode,
                      $mrjc(periodType.hashCode, weekStart.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is HabitDB &&
          other.id == this.id &&
          other.title == this.title &&
          other.order == this.order &&
          other.frequency == this.frequency &&
          other.periodValue == this.periodValue &&
          other.periodType == this.periodType &&
          other.weekStart == this.weekStart);
}

class HabitDBsCompanion extends UpdateCompanion<HabitDB> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> order;
  final Value<int> frequency;
  final Value<int> periodValue;
  final Value<PeriodType> periodType;
  final Value<Weekday> weekStart;
  const HabitDBsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.order = const Value.absent(),
    this.frequency = const Value.absent(),
    this.periodValue = const Value.absent(),
    this.periodType = const Value.absent(),
    this.weekStart = const Value.absent(),
  });
  HabitDBsCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    @required int order,
    @required int frequency,
    @required int periodValue,
    @required PeriodType periodType,
    @required Weekday weekStart,
  })  : title = Value(title),
        order = Value(order),
        frequency = Value(frequency),
        periodValue = Value(periodValue),
        periodType = Value(periodType),
        weekStart = Value(weekStart);
  static Insertable<HabitDB> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<int> order,
    Expression<int> frequency,
    Expression<int> periodValue,
    Expression<int> periodType,
    Expression<int> weekStart,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (order != null) 'order': order,
      if (frequency != null) 'frequency': frequency,
      if (periodValue != null) 'period_value': periodValue,
      if (periodType != null) 'period_type': periodType,
      if (weekStart != null) 'week_start': weekStart,
    });
  }

  HabitDBsCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<int> order,
      Value<int> frequency,
      Value<int> periodValue,
      Value<PeriodType> periodType,
      Value<Weekday> weekStart}) {
    return HabitDBsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      order: order ?? this.order,
      frequency: frequency ?? this.frequency,
      periodValue: periodValue ?? this.periodValue,
      periodType: periodType ?? this.periodType,
      weekStart: weekStart ?? this.weekStart,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    if (periodValue.present) {
      map['period_value'] = Variable<int>(periodValue.value);
    }
    if (periodType.present) {
      final converter = $HabitDBsTable.$converter0;
      map['period_type'] = Variable<int>(converter.mapToSql(periodType.value));
    }
    if (weekStart.present) {
      final converter = $HabitDBsTable.$converter1;
      map['week_start'] = Variable<int>(converter.mapToSql(weekStart.value));
    }
    return map;
  }
}

class $HabitDBsTable extends HabitDBs with TableInfo<$HabitDBsTable, HabitDB> {
  final GeneratedDatabase _db;
  final String _alias;
  $HabitDBsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false, minTextLength: 1);
  }

  final VerificationMeta _orderMeta = const VerificationMeta('order');
  GeneratedIntColumn _order;
  @override
  GeneratedIntColumn get order => _order ??= _constructOrder();
  GeneratedIntColumn _constructOrder() {
    return GeneratedIntColumn(
      'order',
      $tableName,
      false,
    );
  }

  final VerificationMeta _frequencyMeta = const VerificationMeta('frequency');
  GeneratedIntColumn _frequency;
  @override
  GeneratedIntColumn get frequency => _frequency ??= _constructFrequency();
  GeneratedIntColumn _constructFrequency() {
    return GeneratedIntColumn(
      'frequency',
      $tableName,
      false,
    );
  }

  final VerificationMeta _periodValueMeta =
      const VerificationMeta('periodValue');
  GeneratedIntColumn _periodValue;
  @override
  GeneratedIntColumn get periodValue =>
      _periodValue ??= _constructPeriodValue();
  GeneratedIntColumn _constructPeriodValue() {
    return GeneratedIntColumn(
      'period_value',
      $tableName,
      false,
    );
  }

  final VerificationMeta _periodTypeMeta = const VerificationMeta('periodType');
  GeneratedIntColumn _periodType;
  @override
  GeneratedIntColumn get periodType => _periodType ??= _constructPeriodType();
  GeneratedIntColumn _constructPeriodType() {
    return GeneratedIntColumn(
      'period_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _weekStartMeta = const VerificationMeta('weekStart');
  GeneratedIntColumn _weekStart;
  @override
  GeneratedIntColumn get weekStart => _weekStart ??= _constructWeekStart();
  GeneratedIntColumn _constructWeekStart() {
    return GeneratedIntColumn(
      'week_start',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, order, frequency, periodValue, periodType, weekStart];
  @override
  $HabitDBsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'habit_d_bs';
  @override
  final String actualTableName = 'habit_d_bs';
  @override
  VerificationContext validateIntegrity(Insertable<HabitDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order'], _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency'], _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('period_value')) {
      context.handle(
          _periodValueMeta,
          periodValue.isAcceptableOrUnknown(
              data['period_value'], _periodValueMeta));
    } else if (isInserting) {
      context.missing(_periodValueMeta);
    }
    context.handle(_periodTypeMeta, const VerificationResult.success());
    context.handle(_weekStartMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitDB map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return HabitDB.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $HabitDBsTable createAlias(String alias) {
    return $HabitDBsTable(_db, alias);
  }

  static TypeConverter<PeriodType, int> $converter0 =
      const EnumIndexConverter<PeriodType>(PeriodType.values);
  static TypeConverter<Weekday, int> $converter1 =
      const EnumIndexConverter<Weekday>(Weekday.values);
}

class HabitMarkDB extends DataClass implements Insertable<HabitMarkDB> {
  final int id;
  final int habitId;
  final DateTime created;
  HabitMarkDB(
      {@required this.id, @required this.habitId, @required this.created});
  factory HabitMarkDB.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return HabitMarkDB(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      habitId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}habit_id']),
      created: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || habitId != null) {
      map['habit_id'] = Variable<int>(habitId);
    }
    if (!nullToAbsent || created != null) {
      map['created'] = Variable<DateTime>(created);
    }
    return map;
  }

  HabitMarkDBsCompanion toCompanion(bool nullToAbsent) {
    return HabitMarkDBsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      habitId: habitId == null && nullToAbsent
          ? const Value.absent()
          : Value(habitId),
      created: created == null && nullToAbsent
          ? const Value.absent()
          : Value(created),
    );
  }

  factory HabitMarkDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HabitMarkDB(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      created: serializer.fromJson<DateTime>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'created': serializer.toJson<DateTime>(created),
    };
  }

  HabitMarkDB copyWith({int id, int habitId, DateTime created}) => HabitMarkDB(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        created: created ?? this.created,
      );
  @override
  String toString() {
    return (StringBuffer('HabitMarkDB(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(habitId.hashCode, created.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is HabitMarkDB &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.created == this.created);
}

class HabitMarkDBsCompanion extends UpdateCompanion<HabitMarkDB> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<DateTime> created;
  const HabitMarkDBsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.created = const Value.absent(),
  });
  HabitMarkDBsCompanion.insert({
    this.id = const Value.absent(),
    @required int habitId,
    this.created = const Value.absent(),
  }) : habitId = Value(habitId);
  static Insertable<HabitMarkDB> custom({
    Expression<int> id,
    Expression<int> habitId,
    Expression<DateTime> created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (created != null) 'created': created,
    });
  }

  HabitMarkDBsCompanion copyWith(
      {Value<int> id, Value<int> habitId, Value<DateTime> created}) {
    return HabitMarkDBsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    return map;
  }
}

class $HabitMarkDBsTable extends HabitMarkDBs
    with TableInfo<$HabitMarkDBsTable, HabitMarkDB> {
  final GeneratedDatabase _db;
  final String _alias;
  $HabitMarkDBsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _habitIdMeta = const VerificationMeta('habitId');
  GeneratedIntColumn _habitId;
  @override
  GeneratedIntColumn get habitId => _habitId ??= _constructHabitId();
  GeneratedIntColumn _constructHabitId() {
    return GeneratedIntColumn(
      'habit_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdMeta = const VerificationMeta('created');
  GeneratedDateTimeColumn _created;
  @override
  GeneratedDateTimeColumn get created => _created ??= _constructCreated();
  GeneratedDateTimeColumn _constructCreated() {
    return GeneratedDateTimeColumn('created', $tableName, false,
        defaultValue: currentDateAndTime);
  }

  @override
  List<GeneratedColumn> get $columns => [id, habitId, created];
  @override
  $HabitMarkDBsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'habit_mark_d_bs';
  @override
  final String actualTableName = 'habit_mark_d_bs';
  @override
  VerificationContext validateIntegrity(Insertable<HabitMarkDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id'], _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('created')) {
      context.handle(_createdMeta,
          created.isAcceptableOrUnknown(data['created'], _createdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitMarkDB map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return HabitMarkDB.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $HabitMarkDBsTable createAlias(String alias) {
    return $HabitMarkDBsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $HabitDBsTable _habitDBs;
  $HabitDBsTable get habitDBs => _habitDBs ??= $HabitDBsTable(this);
  $HabitMarkDBsTable _habitMarkDBs;
  $HabitMarkDBsTable get habitMarkDBs =>
      _habitMarkDBs ??= $HabitMarkDBsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habitDBs, habitMarkDBs];
}
