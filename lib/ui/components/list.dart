import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/habit/blocs.dart';
import '../../logic/habit/models.dart';
import '../../logic/habit/view_models.dart';
import '../pages/form.dart';

/// Лист-тайл привычки
class HabitListTile extends StatelessWidget {
  /// Вью-модель привычки
  final HabitVM vm;

  /// Создает лист-тайл
  const HabitListTile({this.vm});

  @override
  Widget build(BuildContext context) => withHabitDoneDismiss(
        context,
        Material(
          elevation: 2,
          type: MaterialType.card,
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              HabitFormPage.routeName,
              arguments: [vm.toHabit(), null],
            ),
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Positioned(
                  child: HabitFrequencyProgress(vm: vm),
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: 0,
                ),
                ListTile(
                  title: Text(vm.title, style: vm.textStyle),
                  subtitle: Text(vm.motivationStr),
                ),
              ],
            ),
          ),
        ),
      );

  /// Создает дисмиссибл, который при свайпе влево создает отметку привычку,
  /// при свайпе вправо удаляет крайнюю отметку привычки
  Dismissible withHabitDoneDismiss(BuildContext context, Widget child) =>
      Dismissible(
        key: vm.key,
        child: child,
        direction: vm.swipeDirection,
        confirmDismiss: (dir) async {
          HabitEvent event;
          if (dir == DismissDirection.endToStart) {
            event = HabitDone(vm.toHabit());
          } else if (dir == DismissDirection.startToEnd) {
            event = HabitUndone(vm.toHabit());
          }
          context.bloc<HabitBloc>().add(event);

          return false;
        },
      );
}

/// Прогресс частоты привычки
/// Например, привычка выполнена 1 / 2 раз в день
class HabitFrequencyProgress extends StatelessWidget {
  /// Создает прогресс
  const HabitFrequencyProgress({
    Key key,
    @required this.vm,
  }) : super(key: key);

  /// Вью-модель привычки
  final HabitVM vm;

  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: pi,
        child: LinearProgressIndicator(
          value: vm.habitMarks.length / vm.habit.frequency,
        ),
      );
}

/// Боттом-нав-бар с типами периодов привычки
/// При нажатии на боттом-нав-бар-айтем, меняется фильтр периода привычек
class PeriodBottomNavBar extends StatefulWidget {
  /// Создает боттом-нав-бар
  const PeriodBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _PeriodBottomNavBarState createState() => _PeriodBottomNavBarState();
}

class _PeriodBottomNavBarState extends State<PeriodBottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) => BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) => BottomNavigationBar(
          items: [
            buildBottomNavigationBarItem(state, PeriodType.days),
            buildBottomNavigationBarItem(state, PeriodType.weeks),
            buildBottomNavigationBarItem(state, PeriodType.months),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
            context
                .bloc<HabitBloc>()
                .add(FilterPeriodTypeEvent(PeriodType.values[currentIndex]));
          },
        ),
      );

  BottomNavigationBarItem buildBottomNavigationBarItem(
    HabitState state,
    PeriodType periodType,
  ) {
    Icon icon;
    String title;

    if (periodType == PeriodType.days) {
      icon = Icon(Icons.view_day);
      title = "День";
    }
    if (periodType == PeriodType.weeks) {
      icon = Icon(Icons.view_week);
      title = "Неделя";
    }
    if (periodType == PeriodType.months) {
      icon = Icon(Icons.calendar_today);
      title = "Месяц";
    }

    var stackChildren = <Widget>[icon];

    var undoneHabitCount = state.countUndoneWithPeriodType(periodType);
    if (undoneHabitCount > 0) {
      var undoneHabitCounter = Positioned(
        child: CircleAvatar(
          child: Text(undoneHabitCount.toString()),
          radius: 8,
        ),
        right: -8,
        top: -8,
      );
      stackChildren.add(undoneHabitCounter);
    }

    return BottomNavigationBarItem(
      icon: Stack(
        children: stackChildren,
        overflow: Overflow.visible,
      ),
      label: title,
    );
  }
}
