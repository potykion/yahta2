import 'package:flutter/material.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/ui/components/form.dart';

class HabitFormPage extends StatefulWidget {
  static const routeName = "/form";

  final int id = 1;
  final String title = "a";
  final HabitFrequency frequency = HabitFrequency.monthly;

  const HabitFormPage({
    Key key,
  }) : super(key: key);

  @override
  _HabitFormPageState createState() => _HabitFormPageState();
}

class _HabitFormPageState extends State<HabitFormPage> {
  // TEC = TextEditingController
  TextEditingController habitTitleTEC = TextEditingController();
  TextEditingController habitFrequencyTEC = TextEditingController();
  TextEditingController habitPeriodValueTEC = TextEditingController();

  // h = habit
  int hId;
  int hFrequency = 1;
  int hPeriodValue = 1;
  PeriodType hPeriodType = PeriodType.days;
  Weekday hWeekStart = Weekday.monday;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Habit habit = ModalRoute.of(context).settings.arguments;

    setState(() {
      hId = habit?.id;
      hFrequency = habit?.frequency ?? hFrequency;
      hPeriodValue = habit?.periodValue ?? hPeriodValue;
      hPeriodType = habit?.periodType ?? hPeriodType;
      hWeekStart = habit?.weekStart ?? hWeekStart;
    });

    habitTitleTEC.text = habit?.title;

    habitFrequencyTEC.text = hFrequency.toString();
    habitFrequencyTEC.addListener(
      () => setState(() {
        if (habitFrequencyTEC.text.isNotEmpty) {
          hFrequency = int.parse(habitFrequencyTEC.text);
        }
      }),
    );

    habitPeriodValueTEC.text = hPeriodValue.toString();
    habitPeriodValueTEC.addListener(
      () => setState(() {
        if (habitPeriodValueTEC.text.isNotEmpty) {
          hPeriodValue = int.parse(habitPeriodValueTEC.text);
        }
      }),
    );
  }

  String get frequencyAndPeriodStr => FrequencyAndPeriodStr(
        frequency: hFrequency,
        periodValue: hPeriodValue,
        periodType: hPeriodType,
      ).toString();

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
          HabitTitleInput(habitTitleTEC: habitTitleTEC),
          HabitFrequencyInput(habitFrequencyTEC: habitFrequencyTEC),
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
    return hId != null
        ? HabitUpdated(
            id: hId,
            title: habitTitleTEC.text,
            frequency: hFrequency,
            periodValue: hPeriodValue,
            periodType: hPeriodType,
            weekStart: hWeekStart,
          )
        : HabitCreated(
            title: habitTitleTEC.text,
            frequency: hFrequency,
            periodValue: hPeriodValue,
            periodType: hPeriodType,
            weekStart: hWeekStart,
          );
  }
}
