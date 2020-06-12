import 'package:flutter_test/flutter_test.dart';
import 'package:yahta2/logic/habit/models.dart';
import 'package:yahta2/logic/habit/utils.dart';

main() {
  test("Тестим сдвиг", () {
    expect(shift([1, 2, 3], 1, 0), [2, 1, 3]);
  });

  test("Тестим перестановку привычек", () {
    expect(
        reorderHabits(
          [
            Habit(id: 1, title: "title1", order: 1),
            Habit(id: 2, title: "title2", order: 2),
            Habit(id: 3, title: "title3", order: 3),
          ],
          2,
          0,
        ),
        orderedEquals([
          Habit(id: 3, title: "title3", order: 1),
          Habit(id: 1, title: "title1", order: 2),
          Habit(id: 2, title: "title2", order: 3),
        ]));
  });
}
