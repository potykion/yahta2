import 'package:yahta2/logic/habit/models.dart';

class HabitVM {
  final int id;
  final String title;
  final HabitFrequency frequency;
  final int order;
  final bool done;

  HabitVM({this.id, this.title, this.frequency, this.order, this.done});

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
}
