import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/ui/components/form.dart';
import 'package:yahta2/ui/components/list_tile.dart';

class HabitListPage extends StatefulWidget {
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("План на сегодня"),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) => IconButton(
                icon: Icon(Icons.add),
                onPressed: () => Scaffold.of(context)
                    .showBottomSheet((_) => HabitFormCard()),
              ),
            )
          ],
        ),
        body: BlocBuilder<HabitBloc, HabitState>(
          builder: (_, state) => ReorderableListView(
            onReorder: (oldIndex, newIndex) => context
                .bloc<HabitBloc>()
                .add(HabitReordered(oldIndex, newIndex)),
            children: state.habitVMs
                .map(
                  (vm) => HabitListTile(
                    habit: vm,
                    key: Key(vm.id.toString()),
                  ),
                )
                .toList(),
          ),
        ),
      );
}
