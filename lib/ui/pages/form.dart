import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../logic/habit/blocs.dart';
import '../../logic/habit/db.dart';
import '../../logic/habit/models.dart';
import '../../logic/habit/utils.dart';
import '../components/form.dart';

/// Страничка редактирования/создания привычки
class HabitFormPage extends StatefulWidget {
  /// Урл страницы
  static const routeName = "/form";

  @override
  _HabitFormPageState createState() => _HabitFormPageState();
}

class _HabitFormPageState extends State<HabitFormPage> {
  // h = habit
  int hId;
  String hTitle;
  int hFrequency;
  int hPeriodValue;
  PeriodType hPeriodType;
  Weekday hWeekStart;
  DateTime hStartTime;
  String hPlace;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var habitAndPeriodType = ModalRoute.of(context).settings.arguments as List;
    var habit = habitAndPeriodType[0] as Habit;
    var periodType = habitAndPeriodType[1] as PeriodType;
    setState(() {
      hId = habit?.id;
      hTitle = habit?.title ?? "";
      hFrequency = habit?.frequency ?? 1;
      hPeriodValue = habit?.periodValue ?? 1;
      hPeriodType = habit?.periodType ?? periodType ?? PeriodType.days;
      hWeekStart = habit?.weekStart ?? Weekday.monday;
      hStartTime = habit?.startTime ?? FixedDateTime.now().value;
      hPlace = habit?.place ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var actions = <Widget>[];

    if (hId != null) {
      actions.add(IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Удаление привычки"),
                  content: Text("Вы хотите удалить привычку?"),
                  actions: [
                    FlatButton(
                      child: Text("Нет"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text("Да"),
                      onPressed: () {
                        context.bloc<HabitBloc>().add(HabitDeleted(hId));
                        // Закрываем диалог + закрываем форму
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
      ));
    }

    actions.add(IconButton(
      icon: Icon(Icons.check),
      onPressed: () {
        context.bloc<HabitBloc>().add(buildHabitEvent());
        Navigator.pop(context);
      },
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          hId != null ? "Изменить привычку" : "Создать привычку",
        ),
        actions: actions,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HabitTitleInput(
                initialTitle: hTitle,
                onTitleChange: (title) => setState(() => hTitle = title),
              ),
              HabitFrequencyInput(
                initialFreq: hFrequency,
                onFreqChange: (freq) => setState(() => hFrequency = freq),
              ),
              HabitPeriodInput(
                initialPeriodValue: hPeriodValue,
                initialPeriodType: hPeriodType,
                onPeriodValueChange: (v) => setState(() => hPeriodValue = v),
                onPeriodTypeChange: (t) => setState(() => hPeriodType = t),
              ),
              HabitFrequencyAndPeriodLabel(
                frequency: hFrequency,
                periodValue: hPeriodValue,
                periodType: hPeriodType,
              ),
              hPeriodType == PeriodType.weeks
                  ? HabitWeekStartInput(
                      initialWeekStart: hWeekStart,
                      onWeekStartChange: (w) => setState(() => hWeekStart = w),
                    )
                  : Container(),
              HabitStartTimeInput(
                initialStartTime: hStartTime,
                onStartTimeChange: (time) => setState(() => hStartTime = time),
              ),
              HabitPlaceInput(
                onPlacePatternChange: (pattern) => context
                    .read<HabitRepository>()
                    .findHabitPlacesByPattern(pattern),
                onPlaceChange: (place) => setState(() => hPlace = place),
                initialPlace: hPlace,
              )
            ],
          ),
        ),
      ),
    );
  }

  HabitEvent buildHabitEvent() {
    return hId != null
        ? HabitUpdated(
            id: hId,
            title: hTitle,
            frequency: hFrequency,
            periodValue: hPeriodValue,
            periodType: hPeriodType,
            weekStart: hWeekStart,
            startTime: hStartTime,
            place: hPlace,
          )
        : HabitCreated(
            title: hTitle,
            frequency: hFrequency,
            periodValue: hPeriodValue,
            periodType: hPeriodType,
            weekStart: hWeekStart,
            startTime: hStartTime,
            place: hPlace,
          );
  }
}
