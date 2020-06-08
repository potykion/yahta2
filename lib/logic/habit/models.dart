class Habit {
  final int id;
  final String title;

  Habit({this.id, this.title});

  Habit copyWith({id, title}) => Habit(
        id: id ?? this.id,
        title: title ?? this.title,
      );
}
