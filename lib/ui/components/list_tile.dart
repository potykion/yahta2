import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/view_models.dart';
import 'package:yahta2/ui/pages/form.dart';

enum HabitAction { edit, delete }

class HabitListTile extends StatelessWidget {
  final HabitVM vm;

  const HabitListTile({Key key, this.vm}) : super(key: key);

  @override
  Widget build(context) => Dismissible(
        key: Key(vm.id.toString()),
        child: ListTile(
          title: Text(
            vm.title,
            style: TextStyle(
              decoration: vm.done ? TextDecoration.lineThrough : null,
              color: vm.done ? Colors.grey : null,
              fontWeight:
                  !vm.done && vm.timeToPerformHabit ? FontWeight.bold : null,
            ),
          ),
          trailing: PopupMenuButton<HabitAction>(
            onSelected: (action) {
              if (action == HabitAction.delete) {
                context.bloc<HabitBloc>().add(HabitDeleted(vm.id));
              } else if (action == HabitAction.edit) {
                Navigator.pushNamed(
                  context,
                  HabitFormPage.routeName,
                  arguments: vm.toHabit(),
                );
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<HabitAction>>[
              const PopupMenuItem<HabitAction>(
                value: HabitAction.edit,
                child: Text('Изменить'),
              ),
              const PopupMenuItem<HabitAction>(
                value: HabitAction.delete,
                child: Text('Удалить'),
              ),
            ],
          ),
        ),
        direction: vm.done || vm.partiallyDone
            ? DismissDirection.startToEnd
            : DismissDirection.endToStart,
        confirmDismiss: (DismissDirection dir) async {
          var event;
          event = dir == DismissDirection.endToStart
              ? HabitDone(vm.toHabit())
              : dir == DismissDirection.startToEnd
                  ? HabitUndone(vm.toHabit())
                  : null;
          context.bloc<HabitBloc>().add(event);

          return false;
        },
      );
}
