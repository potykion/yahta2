import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yahta2/logic/habit/utils.dart';

part 'models.freezed.dart';

@freezed
abstract class Habit with _$Habit {
  factory Habit({
    int id,
    @required String title,
    DateTime startTime,
    @Default(1) int frequency,
    @Default(1) int periodValue,
    @Default(PeriodType.days) PeriodType periodType,
    @Default(Weekday.monday) Weekday weekStart,
  }) = _Habit;

  @late
  DateRange get dateRange => this.periodType == PeriodType.days
      ? DayDateRange(value: this.periodValue)
      : this.periodType == PeriodType.weeks
          ? WeekDateRange(weekStartDay: this.weekStart, value: this.periodValue)
          : MonthDateRange(value: this.periodValue);
}

@freezed
abstract class HabitMark with _$HabitMark {
  factory HabitMark({
    int id,
    @required int habitId,
    @required DateTime created,
  }) = _HabitMark;
}

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension WeekdayToStr on Weekday {
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

enum HabitFrequency { daily, weekly, monthly }

extension HabitFrequencyToStr on HabitFrequency {
  String toVerboseStr() {
    if (this == HabitFrequency.daily) {
      return "Ежедневно";
    }
    if (this == HabitFrequency.weekly) {
      return "Еженедельно";
    }
    if (this == HabitFrequency.monthly) {
      return "Ежемесячно";
    }
    throw "Dunno how to handle: $this";
  }
}

enum PeriodType { days, weeks, months }

extension PeriodToStr on PeriodType {
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

class FrequencyAndPeriodStr {
  final int frequency;
  final int periodValue;
  final PeriodType periodType;

  FrequencyAndPeriodStr({
    this.frequency = 1,
    this.periodValue = 1,
    this.periodType = PeriodType.days,
  });

  @override
  String toString() {
    var frequencyStr = this.frequency == 1
        ? "раз"
        : this.frequency == 2 || this.frequency == 3 || this.frequency == 4
            ? "раза"
            : "раз";

    var periodStr = this.periodType == PeriodType.days
        ? this.periodValue == 1
            ? "день"
            : this.periodValue == 2 ||
                    this.periodValue == 3 ||
                    this.periodValue == 4
                ? "$periodValue дня"
                : "$periodValue дней"
        : this.periodType == PeriodType.weeks
            ? this.periodValue == 1
                ? "неделю"
                : this.periodValue == 2 ||
                        this.periodValue == 3 ||
                        this.periodValue == 4
                    ? "$periodValue недели"
                    : "$periodValue недель"
            : this.periodType == PeriodType.months
                ? this.periodValue == 1
                    ? "месяц"
                    : this.periodValue == 2 ||
                            this.periodValue == 3 ||
                            this.periodValue == 4
                        ? "$periodValue месяца"
                        : "$periodValue месяцев"
                : "wtf: $this";
    return "$frequency $frequencyStr в $periodStr";
  }
}
