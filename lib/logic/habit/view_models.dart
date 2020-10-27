import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models.dart';

/// Вью-моделька привычки, используемая в списке привычек
class HabitVM {
  /// Привычка
  final Habit habit;

  /// Отметка привычки
  final List<HabitMark> habitMarks;

  /// Создает вью-модель
  HabitVM({this.habit, this.habitMarks});

  /// Название привычки
  String get title => habit.title;

  /// Когда и где делать привычку
  String get motivationStr {
    var parts = <String>[];

    if (habit.startTime != null) {
      parts.add("Время: ${DateFormat.Hm().format(habit.startTime)}");
    }

    if (habit.place != null && habit.place.length > 0) {
      parts.add("Место: ${habit.place}");
    }

    return parts.join(" • ");
  }

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

  /// Выполнена ли привычка, например 2 раза за день
  bool get done => habitMarks.length == habit.frequency;

  /// Определяет выполнена ли привычка частично
  bool get partiallyDone =>
      habitMarks.length > 0 && habitMarks.length != habit.frequency;

  /// Отображение прогресса привычки
  bool get showProgress => !done && habit.frequency != 1;

  /// Необходимо для рендеринга виджетов
  Key get key => Key(habit.id.toString());

  /// Направление свайпа привычки
  /// Налево - создает отметку привычки
  /// Направо - удаляет последнюю отметку привычки
  DismissDirection get swipeDirection => done
      ? DismissDirection.startToEnd
      : partiallyDone
          ? DismissDirection.horizontal
          : DismissDirection.endToStart;

  /// Стиль текста привычка
  /// Если выполнена, то серый + зачеркнутый текст
  /// Если наступило время делать привычку, то жирный шрифт
  TextStyle get textStyle => TextStyle(
        decoration: done ? TextDecoration.lineThrough : null,
        color: done ? Colors.grey : null,
        fontWeight: !done && timeToPerformHabit ? FontWeight.bold : null,
      );

  /// Переводит вью-модель в привычку
  Habit toHabit() => habit;
}
