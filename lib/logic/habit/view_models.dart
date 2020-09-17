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

  HabitVM({
    this.id,
    this.title,
    this.order,
    this.frequency,
    this.periodValue,
    this.periodType,
    this.weekStart,
    this.habitMarks
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
      habitMarks: habitMarks,
    );
  }

  /// В зависимости от частоты определяет пора ли реализовывать привычку
  get timeToPerformHabit =>
      this.frequency == HabitFrequency.daily &&
          // Через 4 часа - конец дня
          DateTime.now().hour >= 24 - 4 ||
      this.frequency == HabitFrequency.weekly &&
          // Через 2 дня - конец недели (+ учет начала недели)
          DateTime.now().weekday == (weekStart.index + 5) % 7 + 1 ||
          DateTime.now().weekday == (weekStart.index + 6) % 7 + 1 ||
      this.frequency == HabitFrequency.monthly &&
          // Через 10 дней - конец месяца
          DateTime.now().day >= 30 - 10;

  get done => habitMarks.length == frequency;
  get partiallyDone => habitMarks.length > 0 && habitMarks.length < frequency;


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
