import 'package:yahta2/logic/habit/models.dart';

class HabitVM {
  final int id;
  final String title;
  final HabitFrequency frequency;
  final int order;
  final bool done;

  HabitVM({this.id, this.title, this.frequency, this.order, this.done});
}
