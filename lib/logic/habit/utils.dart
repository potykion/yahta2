import 'package:flutter/material.dart';

import 'models.dart';

abstract class DateRange {
  final DateTime now;
  final int value;

  DateRange({DateTime now, int value})
      : this.now = now ?? DateTime.now(),
        this.value = value ?? 1;

  DateTime get from;

  DateTime get to;

  bool containsDate(DateTime date) => date.isAfter(from) && date.isBefore(to);
}

class DayDateRange extends DateRange {
  DayDateRange({DateTime now, int value}) : super(now: now, value: value);

  DateTime get from => DateTime(now.year, now.month, now.day);

  DateTime get to => DateTime(now.year, now.month, now.day, 23, 59, 59)
      .add(Duration(days: value - 1));
}

class WeekDateRange extends DateRange {
  Weekday weekStartDay;

  WeekDateRange({DateTime now, int value, this.weekStartDay = Weekday.monday})
      : super(now: now, value: value);

  List<int> get weekDaysFromStart =>
      List.generate(7, (index) => (weekStartDay.index + index) % 7 + 1);

  DateTime get weekStart =>
      now.add(Duration(days: -weekDaysFromStart.indexOf(now.weekday)));

  DateTime get weekEnd =>
      weekStart.add(Duration(days: 6)).add(Duration(days: 7 * (value - 1)));

  DateTime get from => DateTime(weekStart.year, weekStart.month, weekStart.day);

  DateTime get to =>
      DateTime(weekEnd.year, weekEnd.month, weekEnd.day, 23, 59, 59);
}

class MonthDateRange extends DateRange {
  MonthDateRange({DateTime now, int value}) : super(now: now, value: value);

  DateTime get from => DateTime(now.year, now.month, 1);

  // 0 - end of the previous mouth
  DateTime get to =>
      DateTime(now.year, now.month + 1 + value - 1, 0, 23, 59, 59);
}

bool simpleEquals(dynamic a, dynamic b) => a == b;

bool idEquals(dynamic a, dynamic b) => a.id == b.id;

class FixedDateTime {
  final DateTime value;

  FixedDateTime._(this.value);

  factory FixedDateTime.fromTimeOfDay(TimeOfDay time) =>
      FixedDateTime._(DateTime(2020, 1, 1, time.hour, time.minute));

  factory FixedDateTime.now() => FixedDateTime.fromTimeOfDay(TimeOfDay.now());
}
