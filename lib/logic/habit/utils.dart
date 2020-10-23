import 'package:flutter/material.dart';

import 'models.dart';

/// Промежуток дат
abstract class DateRange {
  final DateTime now;
  final int value;

  DateRange({DateTime now, int value})
      : this.now = now ?? DateTime.now(),
        this.value = value ?? 1;

  /// Начало промежутка
  DateTime get from;

  /// Конец промежутка
  DateTime get to;

  /// Чекает входит ли дата в промежуток
  bool containsDate(DateTime date) => date.isAfter(from) && date.isBefore(to);
}

/// Дневной промежуток дат
/// Например, 2020-10-23 00:00 - 2020-10-23 23:59
class DayDateRange extends DateRange {
  DayDateRange({DateTime now, int value}) : super(now: now, value: value);

  DateTime get from => DateTime(now.year, now.month, now.day);

  DateTime get to => DateTime(now.year, now.month, now.day, 23, 59, 59)
      .add(Duration(days: value - 1));
}

/// Недельный промежуток дат
/// Например, 2020-10-19 00:00 - 2020-10-25 23:59
class WeekDateRange extends DateRange {
  /// Начало недели
  /// Например, если вт, то дейтренж будет таким:
  /// 2020-10-20 00:00 - 2020-10-26 23:59
  Weekday weekStartDay;

  WeekDateRange({DateTime now, int value, this.weekStartDay = Weekday.monday})
      : super(now: now, value: value);

  /// Дни недели с учетом начала недели
  /// Для пн это 1, 2, ..., 6, 7
  /// Для вт это 2, 3, ..., 7, 1
  List<int> get weekDaysFromStart =>
      List.generate(7, (index) => (weekStartDay.index + index) % 7 + 1);

  /// Дата начала недели
  DateTime get weekStart =>
      now.add(Duration(days: -weekDaysFromStart.indexOf(now.weekday)));

  /// Дата конца недели
  DateTime get weekEnd =>
      weekStart.add(Duration(days: 6)).add(Duration(days: 7 * (value - 1)));

  DateTime get from => DateTime(weekStart.year, weekStart.month, weekStart.day);

  DateTime get to =>
      DateTime(weekEnd.year, weekEnd.month, weekEnd.day, 23, 59, 59);
}

/// Месячный промежуток дат
/// Например, 2020-10-01 00:00 - 2020-10-31 23:59
class MonthDateRange extends DateRange {
  MonthDateRange({DateTime now, int value}) : super(now: now, value: value);

  DateTime get from => DateTime(now.year, now.month, 1);

  DateTime get to =>
      // 0 - конец предыдущего месяца
      DateTime(now.year, now.month + 1 + value - 1, 0, 23, 59, 59);
}

/// Функция, чекающая, что объекты равны
bool simpleEquals(dynamic a, dynamic b) => a == b;

/// Функция, чекающая, что айди объектов равны
bool idEquals(dynamic a, dynamic b) => a.id == b.id;

/// Дейттайм с фиксированной датой - 2020-01-01
/// Используется в Habit.startTime
class FixedDateTime {
  final DateTime value;

  FixedDateTime._(this.value);

  /// Создает с конкретным временем
  factory FixedDateTime.fromTimeOfDay(TimeOfDay time) =>
      FixedDateTime._(DateTime(2020, 1, 1, time.hour, time.minute));

  /// Создает с текущим временем
  factory FixedDateTime.now() => FixedDateTime.fromTimeOfDay(TimeOfDay.now());
}
