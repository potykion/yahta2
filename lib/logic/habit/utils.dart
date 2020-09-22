import 'models.dart';

abstract class DateRange {
  final DateTime now;
  final int value;

  DateRange({now, value})
      : this.now = now ?? DateTime.now(),
        this.value = value ?? 1;

  DateTime get from;

  DateTime get to;

  containsDate(DateTime date) => date.isAfter(from) && date.isBefore(to);
}

class DayDateRange extends DateRange {
  DayDateRange({now, value}) : super(now: now, value: value);

  DateTime get from => DateTime(now.year, now.month, now.day);

  DateTime get to => DateTime(now.year, now.month, now.day, 23, 59, 59)
      .add(Duration(days: value - 1));
}

class WeekDateRange extends DateRange {
  Weekday weekStartDay;

  WeekDateRange({now, value, this.weekStartDay = Weekday.monday})
      : super(now: now, value: value);

  List<int> get weekDaysFromStart =>
      List.generate(7, (index) => (weekStartDay.index + index) % 7 + 1);

  DateTime get weekStart =>
      now.add(Duration(days: -weekDaysFromStart.indexOf(now.weekday)));

  DateTime get weekEnd =>
      weekStart.add(Duration(days: 6)).add(Duration(days: 7 * (value - 1)));

  DateTime get from => DateTime(weekStart.year, weekStart.month, weekStart.day);

  DateTime get to =>
      DateTime(weekEnd.year, weekEnd.month, weekEnd.day, 23, 59, 59);
}

class MonthDateRange extends DateRange {
  MonthDateRange({now, value}) : super(now: now, value: value);

  DateTime get from => DateTime(now.year, now.month, 1);

  // 0 - end of the previous mouth
  DateTime get to =>
      DateTime(now.year, now.month + 1 + value - 1, 0, 23, 59, 59);
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
