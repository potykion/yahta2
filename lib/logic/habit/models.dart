import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:yahta2/logic/habit/utils.dart';

part 'models.freezed.dart';

@freezed
abstract class Habit with _$Habit {
  factory Habit(
      {int id,
      @required String title,
      int order,
      @Default(HabitFrequency.daily) HabitFrequency frequency}) = _Habit;
}

@freezed
abstract class HabitMark with _$HabitMark {
  factory HabitMark({
    int id,
    @required int habitId,
    @required DateTime created,
  }) = _HabitMark;
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

extension HabitFrequencyToDateRange on HabitFrequency {
  DateRange toDateRange() {
    if (this == HabitFrequency.daily) {
      return DayDateRange();
    }
    if (this == HabitFrequency.weekly) {
      return WeekDateRange();
    }
    if (this == HabitFrequency.monthly) {
      return MonthDateRange();
    }
    throw "Dunno how to handle: $this";
  }
}
