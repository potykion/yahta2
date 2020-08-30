import 'package:flutter_test/flutter_test.dart';
import 'package:yahta2/logic/habit/utils.dart';

main() {
  group("Тестим дейт ренжи", () {
    test("Тестим дейт ренж дня", () {
      var dateRange = DayDateRange(now: DateTime(2020, 8, 31));
      expect(dateRange.from, DateTime(2020, 8, 31));
      expect(dateRange.to, DateTime(2020, 8, 31, 23, 59, 59));
    });

    test("Тестим дейт ренж недели", () {
      var dateRange = WeekDateRange(now: DateTime(2020, 8, 31));
      expect(dateRange.from, DateTime(2020, 8, 31));
      expect(dateRange.to, DateTime(2020, 9, 6, 23, 59, 59));

      dateRange = WeekDateRange(now: DateTime(2020, 9, 1));
      expect(dateRange.from, DateTime(2020, 8, 31));
      expect(dateRange.to, DateTime(2020, 9, 6, 23, 59, 59));
    });

    test("Тестим дейт ренж месяца", () {
      var dateRange = MonthDateRange(now: DateTime(2020, 8, 31));
      expect(dateRange.from, DateTime(2020, 8, 1));
      expect(dateRange.to, DateTime(2020, 8, 31, 23, 59, 59));

      dateRange = MonthDateRange(now: DateTime(2020, 12, 31));
      expect(dateRange.from, DateTime(2020, 12, 1));
      expect(dateRange.to, DateTime(2020, 12, 31, 23, 59, 59));
    });
  });
}
