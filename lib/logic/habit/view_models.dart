import 'package:yahta2/logic/habit/models.dart';

class HabitVM {
  final int id;
  final String title;
  final int order;
  final int frequency;
  final int periodValue;
  final PeriodType periodType;
  final Weekday weekStart;
  final bool done;

  HabitVM({
    this.id,
    this.title,
    this.order,
    this.frequency,
    this.periodValue,
    this.periodType,
    this.weekStart,
    this.done,
  });

  factory HabitVM.build(Habit habit, List<HabitMark> habitMarks) {
    return HabitVM(
      id: habit.id,
      title: habit.title,
      order: habit.order,
      frequency: habit.frequency,
      periodValue: habit.periodValue,
      periodType: habit.periodType,
      weekStart: habit.weekStart,
      done: habitMarks.length == habit.frequency,
    );
  }

  /// В зависимости от частоты определяет пора ли реализовывать привычку
  get timeToPerformHabit =>
      this.frequency == HabitFrequency.daily &&
          // Через 4 часа - конец дня
          DateTime.now().hour >= 24 - 4 ||
      this.frequency == HabitFrequency.weekly &&
          // Через 2 дня - конец недели
          DateTime.now().weekday >= 7 - 2 ||
      this.frequency == HabitFrequency.monthly &&
          // Через 10 дней - конец месяца
          DateTime.now().day >= 30 - 10;

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
