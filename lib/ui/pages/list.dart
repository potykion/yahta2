import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/ui/components/list_tile.dart';
import 'package:yahta2/ui/pages/form.dart';

class HabitListPage extends StatefulWidget {
  static const routeName = "/list";

  @override
  _HabitListPageState createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  @override
  void initState() {
    super.initState();
    context.bloc<HabitBloc>().add(HabitsLoadStarted());
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<HabitBloc, HabitState>(
        builder: (_, state) => Scaffold(
          appBar: buildAppBar(context, state),
          body: buildReorderableListView(context, state),
        ),
      );

  ReorderableListView buildReorderableListView(
    BuildContext context,
    HabitState state,
  ) =>
      ReorderableListView(
        onReorder: (oldIndex, newIndex) => context.bloc<HabitBloc>().add(
              HabitReordered(oldIndex, newIndex),
            ),
        children: state.habitVMs
            .map((vm) => HabitListTile(vm: vm, key: vm.key))
            .toList(),
      );

  AppBar buildAppBar(
    BuildContext context,
    HabitState state,
  ) =>
      AppBar(
        title: Text("План на сегодня"),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                context.bloc<HabitBloc>().add(ToggleShowDoneEvent()),
            icon: state.showDone
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.pushNamed(context, HabitFormPage.routeName),
          )
        ],
      );
}
