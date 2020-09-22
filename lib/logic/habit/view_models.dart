import 'package:flutter/material.dart';
import 'package:yahta2/logic/habit/models.dart';

class HabitVM {
  final int id;
  final String title;
  final int order;
  final int frequency;
  final int periodValue;
  final PeriodType periodType;
  final Weekday weekStart;
  final List<HabitMark> habitMarks;

  HabitVM(
      {this.id,
      this.title,
      this.order,
      this.frequency,
      this.periodValue,
      this.periodType,
      this.weekStart,
      this.habitMarks});

  factory HabitVM.build(Habit habit, List<HabitMark> habitMarks) {
    return HabitVM(
      id: habit.id,
      title: habit.title,
      order: habit.order,
      frequency: habit.frequency,
      periodValue: habit.periodValue,
      periodType: habit.periodType,
      weekStart: habit.weekStart,
      habitMarks: habitMarks,
    );
  }

  /// В зависимости от частоты определяет пора ли реализовывать привычку
  get timeToPerformHabit {
    if (this.periodType == PeriodType.days) {
      // Через 4 часа - конец дня
      return DateTime.now().hour >= 24 - 4;
    } else if (this.periodType == PeriodType.weeks) {
      // Через 2 дня - конец недели (+ учет начала недели)
      return DateTime.now().weekday == (weekStart.index + 5) % 7 + 1 ||
          DateTime.now().weekday == (weekStart.index + 6) % 7 + 1;
    } else if (this.periodType == PeriodType.months) {
      // Через 10 дней - конец месяца
      return DateTime.now().day >= 30 - 10;
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
