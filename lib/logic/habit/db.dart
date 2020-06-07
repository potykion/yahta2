import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:developer' as developer;

import 'models.dart';

part 'db.g.dart';

class HabitDBs extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1)();
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
}

class HabitRepository {
  final MyDatabase db;

  HabitRepository(this.db);

  Future<int> insertHabit(Habit habit) {
    developer.log(habit.title);
    return db.insertHabit(HabitDBsCompanion.insert(title: habit.title));
  }

  Future<List<Habit>> listHabits() async =>
      (await listHabits()).map((h) => Habit(title: h.title, id: h.id)).toList();
}
