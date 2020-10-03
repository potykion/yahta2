import 'package:flutter/material.dart';

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
  TextEditingController habitTitleTEC;

  @override
  void initState() {
    super.initState();
    habitTitleTEC = TextEditingController(text: widget.initialTitle ?? "");
    habitTitleTEC.addListener(() => widget.onTitleChange(habitTitleTEC.text));
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(labelText: "Чем займешься?"),
        controller: habitTitleTEC,
        autofocus: true,
      );
}

class HabitFrequencyInput extends StatelessWidget {
  const HabitFrequencyInput({
    Key key,
    @required this.habitFrequencyTEC,
  }) : super(key: key);

  // todo initial freq + on freq change
  final TextEditingController habitFrequencyTEC;

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
  const HabitFrequencyAndPeriodLabel({
    Key key,
    @required this.frequencyAndPeriodStr,
  }) : super(key: key);

  final String frequencyAndPeriodStr;

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
