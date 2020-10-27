import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';
import 'utils.dart';

part 'db.g.dart';

/// Табличка с привычками
class HabitDbs extends Table {
  /// См. Habit.id
  IntColumn get id => integer().autoIncrement()();

  /// См. Habit.title
  TextColumn get title => text().withLength(min: 1)();

  /// См. Habit.startTime
  DateTimeColumn get startTime => dateTime()();

  /// См. Habit.place
  TextColumn get place => text().withLength()();

  /// См. Habit.frequency
  IntColumn get frequency => integer()();

  /// См. Habit.periodValue
  IntColumn get periodValue => integer()();

  /// См. Habit.periodType
  IntColumn get periodType => intEnum<PeriodType>()();

  /// См. Habit.weekStart
  IntColumn get weekStart => intEnum<Weekday>()();
}

/// Табличка с отметками привычек
class HabitMarkDBs extends Table {
  /// Айди отметки
  IntColumn get id => integer().autoIncrement()();

  /// Айди привычки
  IntColumn get habitId => integer()();

  /// Дата создания отметки; по умолчанию текущее время
  DateTimeColumn get created => dateTime().withDefault(currentDateAndTime)();
}

/// Создание соединения к бд-файлу
LazyDatabase _openConnection() => LazyDatabase(
      () async {
        final dbFolder = await getApplicationDocumentsDirectory();
        final file = File(p.join(dbFolder.path, 'db.sqlite'));
        return VmDatabase(file);
      },
    );

/// Бдшечка
@UseMoor(tables: [HabitDbs, HabitMarkDBs])
class MyDatabase extends _$MyDatabase {
  /// Создает бд с соединением к бд-файлу
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Вставляет привычку в бд, возвращая айди
  Future<int> insertHabit(HabitDbsCompanion habit) =>
      into(habitDbs).insert(habit);

  /// Возвращает список привычек из бд
  Future<List<HabitDb>> listHabits() => (select(habitDbs)).get();

  /// Возвращает список отметок привычек из бд
  Future<List<HabitMarkDB>> listHabitMarks() {
    return select(habitMarkDBs).get();
  }

  /// Вставляет отметку привычки в бд, возвращая айди
  Future<int> insertHabitMark(HabitMarkDBsCompanion habitMark) =>
      into(habitMarkDBs).insert(habitMark);

  /// Удаляет привычку из бд по айди отметки
  Future deleteHabit(int id) =>
      (delete(habitDbs)..where((tbl) => tbl.id.equals(id))).go();

  /// Удаляет отметки привычек из бд по айди привычки
  Future deleteHabitMarksByHabitId(int habitId) =>
      (delete(habitMarkDBs)..where((tbl) => tbl.habitId.equals(habitId))).go();

  /// Удаляет отметки привычек из бд по айдишникам отметки
  Future deleteHabitMarksByIds(List<int> ids) =>
      (delete(habitMarkDBs)..where((tbl) => tbl.id.isIn(ids))).go();

  /// Обновляет привычку в бд
  Future updateHabit(HabitDb updatedHabit) =>
      update(habitDbs).replace(updatedHabit);

  /// Получает место привычки, которое содержит {pattern}
  Future<List<String>> findHabitPlacesByPattern(String pattern) async =>
      await (selectOnly(habitDbs)
            ..addColumns([habitDbs.place])
            ..where(habitDbs.place.lower().contains(pattern)))
          .map((e) => e.read(habitDbs.place))
          .get();
}

/// Конвертер привычек в бд формат и обратно
class HabitDBConverter {
  /// Создает бд-привычку из привычки
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

  /// Создает привычеку из бд-привычки
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

  /// Создает бд-компаньона привычки, необходимого для вставки привычки в бд
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

/// Персистенс для привычек и отметок
class HabitRepository {
  /// Бд
  final MyDatabase db;

  /// Создает репозиторий
  HabitRepository(this.db);

  /// Вставляет привычку в бд, получая айди, возвращает привычку с айди
  Future<Habit> insertHabit(Habit habit) async {
    var habitId =
        await db.insertHabit(HabitDBConverter.dbInsertFromHabit(habit));
    return habit.copyWith(id: habitId);
  }

  /// Выводит список привычек из бд
  Future<List<Habit>> listHabits() async =>
      (await db.listHabits()).map(HabitDBConverter.dbToHabit).toList();

  /// Выводит список отметок привычек из бд
  Future<List<HabitMark>> listHabitMarks() async => (await db.listHabitMarks())
      .map(
        (hm) => HabitMark(
          id: hm.id,
          created: hm.created,
          habitId: hm.habitId,
        ),
      )
      .toList();

  /// Берет все привычки и отмнетки привычек,
  /// фильтрует отметки в зависимости от того,
  /// содержит ли дейт-ренж привычки отметку
  Future<List<HabitMark>> listHabitMarksDependingOnFreq() async {
    var habits = await listHabits();
    var habitMarks = await listHabitMarks();

    var habitIdToFreq = Map<int, DateRange>.fromIterables(
        habits.map((h) => h.id), habits.map((h) => h.dateRange));
    var habitMarksInDateRange = habitMarks
        .where((hm) => habitIdToFreq[hm.habitId].containsDate(hm.created))
        .toList();

    return habitMarksInDateRange;
  }

  /// Вставляет отметку привычки в бд, получая айди,
  /// возвращает отметку привычки с айди
  Future<HabitMark> insertHabitMark(HabitMark habitMark) async =>
      habitMark.copyWith(
        id: await db.insertHabitMark(
          HabitMarkDBsCompanion.insert(
            habitId: habitMark.habitId,
            created: Value(habitMark.created),
          ),
        ),
      );

  /// Удаляет привычку с айди и все ее отметки из бд
  Future deleteHabitAndMarks(int habitId) async {
    await db.deleteHabit(habitId);
    await db.deleteHabitMarksByHabitId(habitId);
  }

  /// Удаляет отметки привычек по айдишникам
  Future deleteHabitMarks(List<int> habitMarkIds) async {
    await db.deleteHabitMarksByIds(habitMarkIds);
  }

  /// Обновляет привычку в бд
  Future<Habit> updateHabit(Habit habitToUpdate) async {
    await db.updateHabit(HabitDBConverter.dbFromHabit(habitToUpdate));
    return habitToUpdate;
  }

  /// Ищет место привычки по шаблону
  Future<List<String>> findHabitPlacesByPattern(String pattern) async {
    return await db.findHabitPlacesByPattern(pattern);
  }
}

/// Персистенс для настроек
class SettingsRepository {
  /// Сохраняет флаг показа выполненных привычек
  // ignore: avoid_positional_boolean_parameters
  Future setShowDone(bool showDone) async =>
      (await SharedPreferences.getInstance()).setBool("showDone", showDone);

  /// Загружает флаг показа выполненных привычек
  Future<bool> getShowDone() async =>
      (await SharedPreferences.getInstance()).getBool("showDone");
}
