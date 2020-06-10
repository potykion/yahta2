import 'package:flutter/cupertino.dart';

class Habit {
  final int id;
  final String title;
  final int order;

  Habit({this.id, @required this.title, this.order});

  Habit copyWith({id, title, order}) => Habit(
        id: id ?? this.id,
        title: title ?? this.title,
        order: order ?? this.order,
      );
}

class HabitMark {
  final int id;
  final int habitId;
  final DateTime created;

  HabitMark({this.id, this.habitId, created})
      : this.created = created ?? DateTime.now();

  copyWith({int id, int habitId, DateTime dateTime}) => HabitMark(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        created: created ?? this.created,
      );
}
