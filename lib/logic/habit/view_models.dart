import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yahta2/logic/habit/models.dart';

class HabitVM {
  final Habit habit;
  final List<HabitMark> habitMarks;

  HabitVM({this.habit, this.habitMarks});

  factory HabitVM.build(Habit habit, List<HabitMark> habitMarks) =>
      HabitVM(habit: habit, habitMarks: habitMarks);

  String get title => "${DateFormat.Hm().format(habit.startTime)} - ${habit.title}";

  /// В зависимости от частоты определяет пора ли реализовывать привычку
  bool get timeToPerformHabit {
    if (habit.periodType == PeriodType.days) {
      // 4 часа (* periodValue) осталось до конца дня
      return habit.dateRange.to.difference(DateTime.now()).inHours <
          4 * habit.periodValue;
    } else if (habit.periodType == PeriodType.weeks) {
      // Через 2 дня (* periodValue) - конец недели
      return habit.dateRange.to.difference(DateTime.now()).inDays <
          2 * habit.periodValue;
    } else if (habit.periodType == PeriodType.months) {
      // Через 10 дней (* periodValue) - конец месяца
      return habit.dateRange.to.difference(DateTime.now()).inDays <
          10 * habit.periodValue;
    }
    return false;
  }

  bool get done => habitMarks.length == habit.frequency;

  bool get partiallyDone =>
      habitMarks.length > 0 && habitMarks.length != habit.frequency;

  bool get showProgress => !done && habit.frequency != 1;

  Key get key => Key(habit.id.toString());

  DismissDirection get swipeDirection => done
      ? DismissDirection.startToEnd
      : partiallyDone
          ? DismissDirection.horizontal
          : DismissDirection.endToStart;

  TextStyle get textStyle => TextStyle(
        decoration: done ? TextDecoration.lineThrough : null,
        color: done ? Colors.grey : null,
        fontWeight: !done && timeToPerformHabit ? FontWeight.bold : null,
      );

  Habit toHabit() => this.habit;
}
