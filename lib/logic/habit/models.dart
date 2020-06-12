import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'models.freezed.dart';

@freezed
abstract class Habit with _$Habit {
  factory Habit({
    int id,
    @required String title,
    int order,
  }) = _Habit;
}

@freezed
abstract class HabitMark with _$HabitMark {
  factory HabitMark({
    int id,
    @required int habitId,
    @required DateTime created,
  }) = _HabitMark;
}
