import 'models.dart';

abstract class DateRange {
  DateTime get from;

  DateTime get to;
}

class TodayDateRange extends DateRange {
  final DateTime now;

  TodayDateRange({now}) : this.now = now ?? DateTime.now();

  DateTime get from => DateTime(now.year, now.month, now.day);

  DateTime get to => DateTime(now.year, now.month, now.day, 23, 59, 59);
}

simpleEquals(a, b) => a == b;

idEquals(a, b) => a.id == b.id;

List<T> shift<T>(
  List<T> array,
  oldIndex,
  newIndex, {
  equalFunc = simpleEquals,
}) {
  if (oldIndex == newIndex) {
    return array;
  }

  var shiftItem = array[oldIndex];
  return newIndex < oldIndex
      ? [
          ...array.sublist(0, newIndex),
          shiftItem,
          ...(array.sublist(newIndex, array.length)
            ..removeWhere((e) => equalFunc(e, shiftItem)))
        ]
      : [
          ...(array.sublist(0, newIndex + 1)
            ..removeWhere((e) => equalFunc(e, shiftItem))),
          shiftItem,
          ...array.sublist(newIndex + 1, array.length)
        ];
}

List<Habit> reorderHabits(List<Habit> habits, oldIndex, newIndex) =>
    Map.fromIterables(
      shift(habits, oldIndex, newIndex, equalFunc: idEquals),
      habits.map((h) => h.order).toList(),
    ).entries.map((e) => e.key.copyWith(order: e.value)).toList();
