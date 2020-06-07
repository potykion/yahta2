// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class HabitDB extends DataClass implements Insertable<HabitDB> {
  final int id;
  final String title;
  HabitDB({@required this.id, @required this.title});
  factory HabitDB.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return HabitDB(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
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
    return map;
  }

  HabitDBsCompanion toCompanion(bool nullToAbsent) {
    return HabitDBsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
    );
  }

  factory HabitDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HabitDB(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  HabitDB copyWith({int id, String title}) => HabitDB(
        id: id ?? this.id,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('HabitDB(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, title.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is HabitDB && other.id == this.id && other.title == this.title);
}

class HabitDBsCompanion extends UpdateCompanion<HabitDB> {
  final Value<int> id;
  final Value<String> title;
  const HabitDBsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
  });
  HabitDBsCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
  }) : title = Value(title);
  static Insertable<HabitDB> custom({
    Expression<int> id,
    Expression<String> title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
    });
  }

  HabitDBsCompanion copyWith({Value<int> id, Value<String> title}) {
    return HabitDBsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
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

  @override
  List<GeneratedColumn> get $columns => [id, title];
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
