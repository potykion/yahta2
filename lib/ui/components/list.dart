import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/models.dart';
import 'package:yahta2/logic/habit/view_models.dart';
import 'package:yahta2/ui/pages/form.dart';

enum HabitAction { edit, delete }

class HabitListTile extends StatelessWidget {
  final HabitVM vm;

  const HabitListTile({this.vm});

  @override
  Widget build(context) => withHabitDoneDismiss(
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

  Dismissible withHabitDoneDismiss(BuildContext context, Widget child) =>
      Dismissible(
        key: vm.key,
        child: child,
        direction: vm.swipeDirection,
        confirmDismiss: (DismissDirection dir) async {
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

class HabitFrequencyProgress extends StatelessWidget {
  const HabitFrequencyProgress({
    Key key,
    @required this.vm,
  }) : super(key: key);

  final HabitVM vm;

  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: pi,
        child: LinearProgressIndicator(
          value: vm.habitMarks.length / vm.habit.frequency,
        ),
      );
}

class PeriodBottomNavBar extends StatefulWidget {
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
        builder: (BuildContext context, state) => BottomNavigationBar(
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
    Text title;

    if (periodType == PeriodType.days) {
      icon = Icon(Icons.view_day);
      title = Text("День");
    }
    if (periodType == PeriodType.weeks) {
      icon = Icon(Icons.view_week);
      title = Text("Неделя");
    }
    if (periodType == PeriodType.months) {
      icon = Icon(Icons.calendar_today);
      title = Text("Месяц");
    }

    List<Widget> stackChildren = [icon];

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
      title: title,
    );
  }
}
