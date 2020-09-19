import 'models.dart';

abstract class DateRange {
  final DateTime now;

  DateRange({now}) : this.now = now ?? DateTime.now();

  DateTime get from;

  DateTime get to;

  containsDate(DateTime date) => date.isAfter(from) && date.isBefore(to);
}

class DayDateRange extends DateRange {
  DayDateRange({now}) : super(now: now);

  DateTime get from => DateTime(now.year, now.month, now.day);

  DateTime get to => DateTime(now.year, now.month, now.day, 23, 59, 59);
}

class WeekDateRange extends DateRange {
  Weekday weekStartDay;

  WeekDateRange({now, this.weekStartDay = Weekday.monday}) : super(now: now);

  List<int> get weekStartDays =>
      List.generate(7, (index) => (weekStartDay.index + index) % 7 + 1);

  DateTime get weekStart =>
      now.add(Duration(days: -weekStartDays.indexOf(now.weekday)));

  DateTime get weekEnd => weekStart.add(Duration(days: 6));

  DateTime get from => DateTime(weekStart.year, weekStart.month, weekStart.day);

  DateTime get to =>
      DateTime(weekEnd.year, weekEnd.month, weekEnd.day, 23, 59, 59);
}

class MonthDateRange extends DateRange {
  MonthDateRange({now}) : super(now: now);

  DateTime get from => DateTime(now.year, now.month, 1);

  // 0 - end of the previous mouth
  DateTime get to => DateTime(now.year, now.month + 1, 0, 23, 59, 59);
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
