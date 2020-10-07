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
                trailing: HabitListTileActions(vm: vm),
              ),
            ],
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

class HabitListTileActions extends StatelessWidget {
  const HabitListTileActions({
    Key key,
    @required this.vm,
  }) : super(key: key);

  final HabitVM vm;

  @override
  Widget build(BuildContext context) => PopupMenuButton<HabitAction>(
        onSelected: (action) {
          if (action == HabitAction.delete) {
            context.bloc<HabitBloc>().add(HabitDeleted(vm.habit.id));
          } else if (action == HabitAction.edit) {
            Navigator.pushNamed(
              context,
              HabitFormPage.routeName,
              arguments: vm.toHabit(),
            );
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<HabitAction>>[
          PopupMenuItem(value: HabitAction.edit, child: Text('Изменить')),
          PopupMenuItem(value: HabitAction.delete, child: Text('Удалить')),
        ],
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
  Widget build(BuildContext context) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_day),
            title: Text("День"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_week),
            title: Text("Неделя"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            title: Text("Месяц"),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
          context
              .bloc<HabitBloc>()
              .add(FilterPeriodTypeEvent(PeriodType.values[currentIndex]));
        },
      );
}
