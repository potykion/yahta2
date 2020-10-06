import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yahta2/logic/habit/utils.dart';

import 'models.dart';

part 'db.g.dart';

class HabitDbs extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1)();

  DateTimeColumn get startTime => dateTime()();

  TextColumn get place => text().withLength()();

  IntColumn get frequency => integer()();

  IntColumn get periodValue => integer()();

  IntColumn get periodType => intEnum<PeriodType>()();

  IntColumn get weekStart => intEnum<Weekday>()();
}

class HabitMarkDBs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get habitId => integer()();

  DateTimeColumn get created => dateTime().withDefault(currentDateAndTime)();
}

LazyDatabase _openConnection() => LazyDatabase(
      () async {
        final dbFolder = await getApplicationDocumentsDirectory();
        final file = File(p.join(dbFolder.path, 'db.sqlite'));
        return VmDatabase(file);
      },
    );

@UseMoor(tables: [HabitDbs, HabitMarkDBs])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertHabit(HabitDbsCompanion habit) =>
      into(habitDbs).insert(habit);

  Future<List<HabitDb>> listHabits() => (select(habitDbs)).get();

  Future<List<HabitMarkDB>> listHabitMarks() {
    return select(habitMarkDBs).get();
  }

  Future<int> insertHabitMark(HabitMarkDBsCompanion habitMark) =>
      into(habitMarkDBs).insert(habitMark);

  Future deleteHabit(int id) =>
      (delete(habitDbs)..where((tbl) => tbl.id.equals(id))).go();

  Future deleteHabitMarksByHabitId(int habitId) =>
      (delete(habitMarkDBs)..where((tbl) => tbl.habitId.equals(habitId))).go();

  Future deleteHabitMarksByIds(List<int> ids) =>
      (delete(habitMarkDBs)..where((tbl) => tbl.id.isIn(ids))).go();

  Future updateHabit(HabitDb updatedHabit) =>
      update(habitDbs).replace(updatedHabit);

  Future<int> getMaxOrder() async {
    var query = "select coalesce(max([order]), 0) as max_order "
        "from ${$HabitDbsTable(null).actualTableName}";
    var row = await customSelect(query).getSingle();
    return row.data["max_order"] as int;
  }

  Future<List<String>> findHabitPlacesByPattern(String pattern) async =>
      await (selectOnly(habitDbs)
            ..addColumns([habitDbs.place])
            ..where(habitDbs.place.lower().contains(pattern)))
          .map((e) => e.read(habitDbs.place))
          .get();
}

class HabitDBConverter {
  static HabitDb dbFromHabit(Habit habit) => HabitDb(
        id: habit.id,
        title: habit.title,
        startTime: habit.startTime,
        place: habit.place,
        frequency: habit.frequency,
        periodValue: habit.periodValue,
        weekStart: habit.weekStart,
        periodType: habit.periodType,
      );

  static Habit dbToHabit(HabitDb habitDb) => Habit(
        title: habitDb.title,
        id: habitDb.id,
        startTime: habitDb.startTime,
        place: habitDb.place,
        frequency: habitDb.frequency,
        periodType: habitDb.periodType,
        periodValue: habitDb.periodValue,
        weekStart: habitDb.weekStart,
      );

  static HabitDbsCompanion dbInsertFromHabit(Habit habit) =>
      HabitDbsCompanion.insert(
        title: habit.title,
        frequency: habit.frequency,
        periodType: habit.periodType,
        periodValue: habit.periodValue,
        weekStart: habit.weekStart,
        startTime: habit.startTime,
        place: habit.place,
      );
}

class HabitRepository {
  final MyDatabase db;

  HabitRepository(this.db);

  Future<Habit> insertHabit(Habit habit) async {
    var habitId =
        await db.insertHabit(HabitDBConverter.dbInsertFromHabit(habit));
    return habit.copyWith(id: habitId);
  }

  Future<List<Habit>> listHabits() async => (await db.listHabits())
      .map((h) => HabitDBConverter.dbToHabit(h))
      .toList();

  Future<List<HabitMark>> listHabitMarks() async => (await db.listHabitMarks())
      .map(
        (hm) => HabitMark(
          id: hm.id,
          created: hm.created,
          habitId: hm.habitId,
        ),
      )
      .toList();

  Future<List<HabitMark>> listHabitMarksDependingOnFreq() async {
    List<Habit> habits = await this.listHabits();
    Map<int, DateRange> habitIdToFreq = Map.fromIterables(
        habits.map((h) => h.id), habits.map((h) => h.dateRange));

    var habitMarks = await this.listHabitMarks();

    var habitMarksInDateRange = habitMarks
        .where((hm) => habitIdToFreq[hm.habitId].containsDate(hm.created))
        .toList();
    return habitMarksInDateRange;
  }

  Future<HabitMark> insertHabitMark(HabitMark habitMark) async =>
      habitMark.copyWith(
        id: await db.insertHabitMark(
          HabitMarkDBsCompanion.insert(
            habitId: habitMark.habitId,
            created: Value(habitMark.created),
          ),
        ),
      );

  Future deleteHabitAndMarks(int habitId) async {
    await db.deleteHabit(habitId);
    await db.deleteHabitMarksByHabitId(habitId);
  }

  Future deleteHabitMarks(List<int> habitMarkIds) async {
    await db.deleteHabitMarksByIds(habitMarkIds);
  }

  Future<Habit> updateHabit(Habit habitToUpdate) async {
    await db.updateHabit(HabitDBConverter.dbFromHabit(habitToUpdate));
    return habitToUpdate;
  }

  Future<List<String>> findHabitPlacesByPattern(String pattern) async {
    return await db.findHabitPlacesByPattern(pattern);
  }
}

class SettingsRepository {
  Future setShowDone(bool showDone) async =>
      (await SharedPreferences.getInstance()).setBool("showDone", showDone);

  Future<bool> getShowDone() async =>
      (await SharedPreferences.getInstance()).getBool("showDone");
}
