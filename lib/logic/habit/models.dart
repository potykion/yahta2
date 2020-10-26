import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'utils.dart';

part 'models.freezed.dart';

/// Привычка
@freezed
abstract class Habit with _$Habit {
  /// Создает привычку
  factory Habit({
    /// Айди
    int id,

    /// Название
    @required String title,

    /// В какое время делать привычку
    @required DateTime startTime,

    /// В каком месте делать привычку
    @required String place,

    /// Как часто делать привычку (1 раз в день, 2 раза в день, ...)
    @Default(1) int frequency,

    /// Значение периода (1 раз в день, 1 раз в 2 дня, ...)
    @Default(1) int periodValue,

    /// Тип периода (1 раз в день, 1 раз в неделю, ...)
    @Default(PeriodType.days) PeriodType periodType,

    /// Начало недели - для еженедельных привычек
    @Default(Weekday.monday) Weekday weekStart,
  }) = _Habit;

  /// Дейт-ренж привычки
  /// Например для ежедневной привычки
  ///   это дейтренж с 00:00 до 23:59 определенного дня
  /// Для еженедельной это дейтренж с пн до вс с учетом начала недели
  @late
  DateRange get dateRange => periodType == PeriodType.days
      ? DayDateRange(value: periodValue)
      : periodType == PeriodType.weeks
          ? WeekDateRange(weekStartDay: weekStart, value: periodValue)
          : MonthDateRange(value: periodValue);
}

/// Отметка привычки - в какое время привычка была совершена
@freezed
abstract class HabitMark with _$HabitMark {
  /// Создает отметку привычки
  factory HabitMark({
    int id,
    @required int habitId,
    @required DateTime created,
  }) = _HabitMark;
}

/// День недели
enum Weekday {
  /// Понедельник
  monday,

  /// Вторник
  tuesday,

  /// Среда
  wednesday,

  /// Четверг
  thursday,

  /// Пятница
  friday,

  /// Суббота
  saturday,

  /// Воскресенье
  sunday,
}

/// Екстеншены для недели
extension WeekdayToStr on Weekday {
  /// Перевод дня недели в строку
  String toVerboseStr() {
    if (this == Weekday.monday) return "понедельник";
    if (this == Weekday.tuesday) return "вторник";
    if (this == Weekday.wednesday) return "среда";
    if (this == Weekday.thursday) return "четверг";
    if (this == Weekday.friday) return "пятница";
    if (this == Weekday.saturday) return "суббота";
    if (this == Weekday.sunday) return "воскресенье";
    throw "Dunno how to handle: $this";
  }
}

/// Тип периода прривычки
enum PeriodType {
  /// ежедневная
  days,

  /// еженедельная
  weeks,

  /// ежемесячная
  months
}

/// Екстеншены для типа периода
extension PeriodToStr on PeriodType {
  /// Склонение периода (1 день, 2 дня, ...)
  String toVerboseStr(int value) {
    if (this == PeriodType.days) {
      if (value == 1) return "день";
      if (value == 2 || value == 3 || value == 4) return "дня";
      return "дней";
    }
    if (this == PeriodType.weeks) {
      if (value == 1) return "неделя";
      if (value == 2 || value == 3 || value == 4) return "недели";
      return "недель";
    }
    if (this == PeriodType.months) {
      if (value == 1) return "месяц";
      if (value == 2 || value == 3 || value == 4) return "месяца";
      return "месяцев";
    }
    throw "Dunno how to handle: $this";
  }
}

/// Частота и период в виде строки (1 раз в день, 2 раза в неделю, ...)
class FrequencyAndPeriodStr {
  /// Частота
  final int frequency;

  /// Значение периода
  final int periodValue;

  /// Тип периода
  final PeriodType periodType;

  /// Создает строку частоты и периода
  FrequencyAndPeriodStr({
    this.frequency = 1,
    this.periodValue = 1,
    this.periodType = PeriodType.days,
  });

  @override
  String toString() {
    var frequencyStr = frequency == 1
        ? "раз"
        : frequency == 2 || frequency == 3 || frequency == 4
            ? "раза"
            : "раз";

    var periodStr = periodType == PeriodType.days
        ? periodValue == 1
            ? "день"
            : periodValue == 2 || periodValue == 3 || periodValue == 4
                ? "$periodValue дня"
                : "$periodValue дней"
        : periodType == PeriodType.weeks
            ? periodValue == 1
                ? "неделю"
                : periodValue == 2 || periodValue == 3 || periodValue == 4
                    ? "$periodValue недели"
                    : "$periodValue недель"
            : periodType == PeriodType.months
                ? periodValue == 1
                    ? "месяц"
                    : periodValue == 2 || periodValue == 3 || periodValue == 4
                        ? "$periodValue месяца"
                        : "$periodValue месяцев"
                : "wtf: $this";
    return "$frequency $frequencyStr в $periodStr";
  }
}
