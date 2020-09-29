import 'package:flutter/material.dart';

class HabitTitleInput extends StatelessWidget {
  const HabitTitleInput({
    Key key,
    @required this.habitTitleTEC,
  }) : super(key: key);

  final TextEditingController habitTitleTEC;

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


