class Habit {
  final int id;
  final String title;

  Habit({this.id, this.title});

  Habit copyWith({id, title}) => Habit(
        id: id ?? this.id,
        title: title ?? this.title,
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
