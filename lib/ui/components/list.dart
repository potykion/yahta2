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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Container(
              child: ListTile(
                title: Text(vm.title, style: vm.textStyle),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vm.motivationStr),
                    SizedBox(height: 8),
                    vm.showProgress
                        ? HabitFrequencyProgress(vm: vm)
                        : Container()
                  ],
                ),
                trailing: HabitListTileActions(vm: vm),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
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
