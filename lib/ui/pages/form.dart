import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/db.dart';
import 'package:yahta2/logic/habit/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/utils.dart';
import 'package:yahta2/ui/components/form.dart';

class HabitFormPage extends StatefulWidget {
  static const routeName = "/form";

  const HabitFormPage({Key key}) : super(key: key);

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

    Habit habit = ModalRoute.of(context).settings.arguments as Habit;
    setState(() {
      hId = habit?.id;
      hTitle = habit?.title ?? "";
      hFrequency = habit?.frequency ?? 1;
      hPeriodValue = habit?.periodValue ?? 1;
      hPeriodType = habit?.periodType ?? PeriodType.days;
      hWeekStart = habit?.weekStart ?? Weekday.monday;
      hStartTime = habit?.startTime ?? FixedDateTime.now().value;
      hPlace = habit?.place ?? "";
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Создание привычки"),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                context.bloc<HabitBloc>().add(buildHabitEvent());
                Navigator.pop(context);
              },
            )
          ],
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
