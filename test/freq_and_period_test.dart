import 'package:flutter_test/flutter_test.dart';
import 'package:yahta2/logic/habit/models.dart';

main() {
  group('Тестим генерацию строки "Частота + период"', () {
    test("Тестим разы", () {
      expect(FrequencyAndPeriodStr(frequency: 1).toString(), "1 раз в день");
      expect(FrequencyAndPeriodStr(frequency: 2).toString(), "2 раза в день");
      expect(FrequencyAndPeriodStr(frequency: 5).toString(), "5 раз в день");
    });

    test("Тестим дни", () {
      expect(FrequencyAndPeriodStr(periodValue: 1, periodType: PeriodType.days,).toString(), "1 раз в день");
      expect(FrequencyAndPeriodStr(periodValue: 2, periodType: PeriodType.days).toString(), "1 раз в 2 дня");
      expect(FrequencyAndPeriodStr(periodValue: 5, periodType: PeriodType.days).toString(), "1 раз в 5 дней");
    });

    test("Тестим недели", () {
      expect(FrequencyAndPeriodStr(periodValue: 1, periodType: PeriodType.weeks).toString(), "1 раз в неделю");
      expect(FrequencyAndPeriodStr(periodValue: 2, periodType: PeriodType.weeks).toString(), "1 раз в 2 недели");
      expect(FrequencyAndPeriodStr(periodValue: 5, periodType: PeriodType.weeks).toString(), "1 раз в 5 недель");
    });

    test("Тестим месяцы", () {
      expect(FrequencyAndPeriodStr(periodValue: 1, periodType: PeriodType.months).toString(), "1 раз в месяц");
      expect(FrequencyAndPeriodStr(periodValue: 2, periodType: PeriodType.months).toString(), "1 раз в 2 месяца");
      expect(FrequencyAndPeriodStr(periodValue: 5, periodType: PeriodType.months).toString(), "1 раз в 5 месяцев");
    });
  });
}
