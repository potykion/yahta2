import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:yahta2/logic/habit/utils.dart';
import 'dart:developer' as developer;

import 'models.dart';

part 'db.g.dart';

class HabitDBs extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1)();

  IntColumn get order => integer()();

  @override
  Set<Column> get primaryKey => {id};
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

@UseMoor(tables: [HabitDBs, HabitMarkDBs])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertHabit(HabitDBsCompanion habit) =>
      into(habitDBs).insert(habit);

  Future<List<HabitDB>> listHabits() => (select(habitDBs)).get();

  Future<List<HabitMarkDB>> listHabitMarksInDateRange(DateRange dateRange) =>
      (select(habitMarkDBs)
            ..where((tbl) =>
                tbl.created.isBetweenValues(dateRange.from, dateRange.to)))
          .get();

  Future<int> insertHabitMark(HabitMarkDBsCompanion habitMark) =>
      into(habitMarkDBs).insert(habitMark);

  Future deleteHabit(int id) =>
      (delete(habitDBs)..where((tbl) => tbl.id.equals(id))).go();

  Future deleteHabitMarks(int habitId) =>
      (delete(habitMarkDBs)..where((tbl) => tbl.habitId.equals(habitId))).go();

  Future updateHabit(HabitDB updatedHabit) =>
      update(habitDBs).replace(updatedHabit);

  Future<int> getMaxOrder() async {
    var query = "select coalesce(max([order]), 0) as max_order "
        "from ${$HabitDBsTable(null).actualTableName}";
    var row = await customSelect(query).getSingle();
    return row.data["max_order"] as int;
  }
}

class HabitRepository {
  final MyDatabase db;

  HabitRepository(this.db);

  Future<Habit> insertHabit(Habit habit) async {
    var newOrder = await db.getMaxOrder() + 1;
    return habit.copyWith(
      id: await db.insertHabit(
        HabitDBsCompanion.insert(
          title: habit.title,
          order: newOrder,
        ),
      ),
      order: newOrder,
    );
  }

  Future<List<Habit>> listHabits() async => (await db.listHabits())
      .map((h) => Habit(title: h.title, id: h.id, order: h.order))
      .toList();

  Future<List<HabitMark>> listTodayHabitMarks() async =>
      (await db.listHabitMarksInDateRange(TodayDateRange()))
          .map(
            (hm) =>
                HabitMark(id: hm.id, created: hm.created, habitId: hm.habitId),
          )
          .toList();

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
    await db.deleteHabitMarks(habitId);
  }

  Future<Habit> updateHabit(Habit habitToUpdate) async {
    await db.updateHabit(
      HabitDB(
          id: habitToUpdate.id,
          title: habitToUpdate.title,
          order: habitToUpdate.order),
    );
    return habitToUpdate;
  }
}
