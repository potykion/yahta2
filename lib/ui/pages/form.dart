import 'package:flutter/material.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/ui/components/form.dart';

class HabitFormPage extends StatefulWidget {
  static const routeName = "/form";

  const HabitFormPage({
    Key key,
  }) : super(key: key);

  @override
  _HabitFormPageState createState() => _HabitFormPageState();
}

class _HabitFormPageState extends State<HabitFormPage> {
  // TEC = TextEditingController
  TextEditingController habitFrequencyTEC = TextEditingController();
  TextEditingController habitPeriodValueTEC = TextEditingController();

  // h = habit
  String hTitle;
  int hFrequency = 1;
  int hPeriodValue = 1;
  PeriodType hPeriodType = PeriodType.days;
  Weekday hWeekStart = Weekday.monday;

  Habit get habit => ModalRoute.of(context).settings.arguments;

  String get frequencyAndPeriodStr => FrequencyAndPeriodStr(
        frequency: hFrequency,
        periodValue: hPeriodValue,
        periodType: hPeriodType,
      ).toString();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      hPeriodValue = habit?.periodValue ?? hPeriodValue;
      hPeriodType = habit?.periodType ?? hPeriodType;
      hWeekStart = habit?.weekStart ?? hWeekStart;
    });

    habitPeriodValueTEC.text = hPeriodValue.toString();
    habitPeriodValueTEC.addListener(
      () => setState(() {
        if (habitPeriodValueTEC.text.isNotEmpty) {
          hPeriodValue = int.parse(habitPeriodValueTEC.text);
        }
      }),
    );
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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: buildForm(context),
        ),
      );

  Column buildForm(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HabitTitleInput(
            initialTitle: habit?.title,
            onTitleChange: (title) => setState(() => hTitle = title),
          ),
          HabitFrequencyInput(
            initialFreq: habit?.frequency,
            onFreqChange: (freq) => setState(() => hFrequency = freq),
          ),
          buildPeriodInput(),
          HabitFrequencyAndPeriodLabel(
            frequencyAndPeriodStr: frequencyAndPeriodStr,
          ),
          hPeriodType == PeriodType.weeks ? buildWeekStartInput() : Container()
        ],
      );

  DropdownButtonFormField<Weekday> buildWeekStartInput() {
    return DropdownButtonFormField<Weekday>(
      decoration: InputDecoration(labelText: "Начало недели"),
      isExpanded: true,
      value: hWeekStart,
      items: Weekday.values
          .map(
            (w) => DropdownMenuItem<Weekday>(
              child: Text(w.toVerboseStr()),
              value: w,
            ),
          )
          .toList(),
      onChanged: (w) => setState(() => hWeekStart = w),
    );
  }

  // todo create stateful widget with initialPeriodValue/Type + onPeriodValue/TypeChange
  Row buildPeriodInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: TextFormField(
            decoration: InputDecoration(labelText: "Период"),
            controller: habitPeriodValueTEC,
            keyboardType: TextInputType.number,
          ),
        ),
        Expanded(
          flex: 4,
          child: DropdownButton<PeriodType>(
            isExpanded: true,
            underline: Container(),
            value: hPeriodType,
            items: PeriodType.values
                .map(
                  (p) => DropdownMenuItem<PeriodType>(
                    child: Text(p.toVerboseStr(hPeriodValue)),
                    value: p,
                  ),
                )
                .toList(),
            onChanged: (periodType) => setState(() => hPeriodType = periodType),
          ),
        )
      ],
    );
  }

  HabitEvent buildHabitEvent() {
    return habit?.id != null
        ? HabitUpdated(
            id: habit?.id,
            title: hTitle,
            frequency: hFrequency,
            periodValue: hPeriodValue,
            periodType: hPeriodType,
            weekStart: hWeekStart,
          )
        : HabitCreated(
            title: hTitle,
            frequency: hFrequency,
            periodValue: hPeriodValue,
            periodType: hPeriodType,
            weekStart: hWeekStart,
          );
  }
}
