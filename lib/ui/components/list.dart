import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/view_models.dart';
import 'package:yahta2/ui/pages/form.dart';

enum HabitAction { edit, delete }

class HabitListTile extends StatelessWidget {
  final HabitVM vm;

  const HabitListTile({this.vm});

  @override
  Widget build(context) => withHabitDoneDismiss(
        context,
        ListTile(
          title: Text(vm.title, style: vm.textStyle),
          subtitle: vm.showProgress ? HabitFrequencyProgress(vm: vm) : null,
          trailing: HabitListTileActions(vm: vm),
        ),
      );

  Dismissible withHabitDoneDismiss(BuildContext context, Widget child) =>
      Dismissible(
        key: vm.key,
        child: child,
        direction: vm.swipeDirection,
        confirmDismiss: (DismissDirection dir) async {
          var event;
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
