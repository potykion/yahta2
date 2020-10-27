import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/habit/blocs.dart';
import '../../logic/habit/models.dart';
import '../components/list.dart';
import 'form.dart';

/// Страничка со списком привычек
class HabitListPage extends StatefulWidget {
  /// Урл странички
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
          body: ListView(
            children: state.habitVMsToShow
                .map((vm) => HabitListTile(vm: vm))
                .toList(),
          ),
          bottomNavigationBar: PeriodBottomNavBar(),
        ),
      );

  AppBar buildAppBar(BuildContext context, HabitState state) {
    String title;
    if (state.filterPeriodType == PeriodType.days) {
      title = "Ежедневные привычки";
    }
    if (state.filterPeriodType == PeriodType.weeks) {
      title = "Еженедельные привычки";
    }
    if (state.filterPeriodType == PeriodType.months) {
      title = "Ежемесячные привычки";
    }

    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          onPressed: () => context.bloc<HabitBloc>().add(ToggleShowDoneEvent()),
          icon: state.showDone
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            HabitFormPage.routeName,
            arguments: [null, state.filterPeriodType],
          ),
        )
      ],
    );
  }
}
