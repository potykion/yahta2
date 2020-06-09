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
