import 'package:flutter/cupertino.dart';
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
  TextEditingController habitTitleTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    habitTitleTEC.text = widget.initialTitle ?? "";
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
