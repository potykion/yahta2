import 'package:flutter/material.dart';
import 'package:yahta2/logic/habit/models.dart';

class HabitVM {
  final Habit habit;
  final List<HabitMark> habitMarks;

  HabitVM({this.habit, this.habitMarks});

  factory HabitVM.build(Habit habit, List<HabitMark> habitMarks) =>
      HabitVM(habit: habit, habitMarks: habitMarks);

  /// В зависимости от частоты определяет пора ли реализовывать привычку
  get timeToPerformHabit {
    if (this.habit.periodType == PeriodType.days) {
      // 4 часа (* periodValue) осталось до конца дня
      return this.habit.dateRange.to.difference(DateTime.now()).inHours <
          4 * this.habit.periodValue;
    } else if (this.habit.periodType == PeriodType.weeks) {
      // Через 2 дня (* periodValue) - конец недели
      return this.habit.dateRange.to.difference(DateTime.now()).inDays <
          2 * this.habit.periodValue;
    } else if (this.habit.periodType == PeriodType.months) {
      // Через 10 дней (* periodValue) - конец месяца
      return this.habit.dateRange.to.difference(DateTime.now()).inDays <
          10 * this.habit.periodValue;
    }
    return false;
  }

  get done => habitMarks.length == frequency;

  get partiallyDone => habitMarks.length > 0 && habitMarks.length != frequency;

  get swipeDirection => done
      ? DismissDirection.startToEnd
      : partiallyDone
          ? DismissDirection.horizontal
          : DismissDirection.endToStart;

  get textStyle => TextStyle(
        decoration: done ? TextDecoration.lineThrough : null,
        color: done ? Colors.grey : null,
        fontWeight: !done && timeToPerformHabit ? FontWeight.bold : null,
      );

  Habit toHabit() {
    return Habit(
      id: id,
      title: title,
      order: order,
      frequency: frequency,
      periodValue: periodValue,
      periodType: periodType,
      weekStart: weekStart,
    );
  }
}
