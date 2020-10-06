import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:yahta2/logic/habit/models.dart';
import 'package:yahta2/logic/habit/utils.dart';

typedef OnTitleChange = void Function(String title);

class HabitTitleInput extends StatefulWidget {
  final String initialTitle;
  final OnTitleChange onTitleChange;

  const HabitTitleInput({Key key, this.initialTitle, this.onTitleChange})
      : super(key: key);

  @override
  _HabitTitleInputState createState() => _HabitTitleInputState();
}

class _HabitTitleInputState extends State<HabitTitleInput> {
  TextEditingController habitTitleTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    habitTitleTEC.text = widget.initialTitle;
    habitTitleTEC.addListener(() => widget.onTitleChange(habitTitleTEC.text));
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(labelText: "Чем займешься?"),
        controller: habitTitleTEC,
        autofocus: true,
      );
}

typedef OnFreqChange = void Function(int freq);

class HabitFrequencyInput extends StatefulWidget {
  final int initialFreq;
  final OnFreqChange onFreqChange;

  const HabitFrequencyInput({Key key, this.initialFreq, this.onFreqChange})
      : super(key: key);

  @override
  _HabitFrequencyInputState createState() => _HabitFrequencyInputState();
}

class _HabitFrequencyInputState extends State<HabitFrequencyInput> {
  final TextEditingController habitFrequencyTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    habitFrequencyTEC.text = widget.initialFreq.toString();
    habitFrequencyTEC.addListener(
      () => setState(() {
        if (habitFrequencyTEC.text.isNotEmpty) {
          widget.onFreqChange(int.parse(habitFrequencyTEC.text));
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          labelText: "Частота",
          hintText: "Сколько раз в период?",
        ),
        controller: habitFrequencyTEC,
        keyboardType: TextInputType.number,
      );
}

class HabitFrequencyAndPeriodLabel extends StatelessWidget {
  final int frequency;
  final int periodValue;
  final PeriodType periodType;

  const HabitFrequencyAndPeriodLabel({
    Key key,
    this.frequency,
    this.periodValue,
    this.periodType,
  }) : super(key: key);

  String get frequencyAndPeriodStr => FrequencyAndPeriodStr(
        frequency: this.frequency,
        periodValue: this.periodValue,
        periodType: this.periodType,
      ).toString();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            "Частота + период: $frequencyAndPeriodStr",
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 16),
        ],
      );
}

typedef OnPeriodValueChange = void Function(int periodValue);
typedef OnPeriodTypeChange = void Function(PeriodType periodType);

class HabitPeriodInput extends StatefulWidget {
  final int initialPeriodValue;
  final PeriodType initialPeriodType;
  final OnPeriodValueChange onPeriodValueChange;
  final OnPeriodTypeChange onPeriodTypeChange;

  const HabitPeriodInput(
      {Key key,
      this.initialPeriodValue,
      this.initialPeriodType,
      this.onPeriodValueChange,
      this.onPeriodTypeChange})
      : super(key: key);

  @override
  _HabitPeriodInputState createState() => _HabitPeriodInputState();
}

class _HabitPeriodInputState extends State<HabitPeriodInput> {
  final TextEditingController habitPeriodValueTEC = TextEditingController();
  PeriodType periodType;

  int get periodValue => int.parse(habitPeriodValueTEC.text);

  @override
  void initState() {
    super.initState();
    habitPeriodValueTEC.text = widget.initialPeriodValue.toString();
    habitPeriodValueTEC.addListener(() {
      if (habitPeriodValueTEC.text.isNotEmpty) {
        widget.onPeriodValueChange(periodValue);
      }
    });

    periodType = widget.initialPeriodType;
  }

  @override
  Widget build(BuildContext context) {
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
            value: periodType,
            items: PeriodType.values
                .map(
                  (p) => DropdownMenuItem<PeriodType>(
                    child: Text(p.toVerboseStr(periodValue)),
                    value: p,
                  ),
                )
                .toList(),
            onChanged: (periodType) {
              setState(() => this.periodType = periodType);
              widget.onPeriodTypeChange(this.periodType);
            },
          ),
        )
      ],
    );
  }
}

typedef OnWeekStartChange = void Function(Weekday weekStart);

class HabitWeekStartInput extends StatefulWidget {
  final Weekday initialWeekStart;
  final OnWeekStartChange onWeekStartChange;

  const HabitWeekStartInput(
      {Key key, this.initialWeekStart, this.onWeekStartChange})
      : super(key: key);

  @override
  _HabitWeekStartInputState createState() => _HabitWeekStartInputState();
}

class _HabitWeekStartInputState extends State<HabitWeekStartInput> {
  Weekday weekStart;

  @override
  void initState() {
    super.initState();
    weekStart = widget.initialWeekStart;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Weekday>(
      decoration: InputDecoration(labelText: "Начало недели"),
      isExpanded: true,
      value: weekStart,
      items: Weekday.values
          .map(
            (w) => DropdownMenuItem<Weekday>(
              child: Text(w.toVerboseStr()),
              value: w,
            ),
          )
          .toList(),
      onChanged: (w) {
        setState(() => weekStart = w);
        widget.onWeekStartChange(weekStart);
      },
    );
  }
}

typedef OnStartTimeChange = void Function(DateTime time);

class HabitStartTimeInput extends StatefulWidget {
  final DateTime initialStartTime;
  final OnStartTimeChange onStartTimeChange;

  const HabitStartTimeInput(
      {Key key, this.initialStartTime, this.onStartTimeChange})
      : super(key: key);

  @override
  _HabitStartTimeInputState createState() => _HabitStartTimeInputState();
}

class _HabitStartTimeInputState extends State<HabitStartTimeInput> {
  TextEditingController controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.text =
        TimeOfDay.fromDateTime(widget.initialStartTime).format(context);
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: "Во сколько делать привычку?"),
        readOnly: true,
        onTap: () async {
          TimeOfDay selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(widget.initialStartTime),
          );
          if (selectedTime != null) {
            controller.text = selectedTime.format(context);
            widget.onStartTimeChange(
              FixedDateTime.fromTimeOfDay(selectedTime).value,
            );
          }
        },
      );
}

typedef OnPlacePatternChange = Future<List<String>> Function(
    String placePattern);
typedef OnPlaceChange = void Function(String place);

class HabitPlaceInput extends StatefulWidget {
  final OnPlacePatternChange onPlacePatternChange;
  final OnPlaceChange onPlaceChange;
  final String initialPlace;

  const HabitPlaceInput({
    Key key,
    this.onPlacePatternChange,
    this.onPlaceChange,
    this.initialPlace,
  }) : super(key: key);

  @override
  _HabitPlaceInputState createState() => _HabitPlaceInputState();
}

class _HabitPlaceInputState extends State<HabitPlaceInput> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialPlace;
    controller.addListener(() => widget.onPlaceChange(controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration<String>(
        controller: this.controller,
        decoration: InputDecoration(labelText: "Где делать привычку?"),
      ),
      // initialValue: this.controller.text,
      hideOnEmpty: true,
      hideOnLoading: true,
        hideSuggestionsOnKeyboardHide: false,
      onSuggestionSelected: (String suggestion) =>
          this.controller.text = suggestion,
      suggestionsCallback: (String pattern) =>
          widget.onPlacePatternChange(pattern),
      itemBuilder: (BuildContext context, String suggestion) => ListTile(
        title: Text(suggestion),
      ),
    );
  }
}
