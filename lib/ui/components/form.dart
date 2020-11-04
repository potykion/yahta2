import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../logic/habit/models.dart';
import '../../logic/habit/utils.dart';

/// Инпут названия привычки
class HabitTitleInput extends StatefulWidget {
  /// Начальное значение названия
  final String initialTitle;

  /// Событие изменения названия привычки
  final Function(String title) onTitleChange;

  /// Создает инпут
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

    /// Кидаем событие измененного названия
    habitTitleTEC.addListener(() => widget.onTitleChange(habitTitleTEC.text));
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(labelText: "Чем займешься?"),
        controller: habitTitleTEC,
        autofocus: true,
      );
}

/// Инпут частоты привычки
class HabitFrequencyInput extends StatefulWidget {
  /// Изначальная частота
  final int initialFreq;

  /// Событие изменения частоты привычки
  final Function(int freq) onFreqChange;

  /// Создает инпут
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

    /// Кидаем событие измененной частоты
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

/// Надпись с частотой и периодом привычки
class HabitFrequencyAndPeriodLabel extends StatelessWidget {
  /// Частота
  final int frequency;

  /// Значение периода
  final int periodValue;

  /// Тип периода
  final PeriodType periodType;

  /// Создает надпись
  const HabitFrequencyAndPeriodLabel({
    Key key,
    this.frequency,
    this.periodValue,
    this.periodType,
  }) : super(key: key);

  /// Частота и период в виде строки
  String get frequencyAndPeriodStr => FrequencyAndPeriodStr(
        frequency: frequency,
        periodValue: periodValue,
        periodType: periodType,
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

/// Инпут значения и типа периода привычки
class HabitPeriodInput extends StatefulWidget {
  /// Изначальное значение периода
  final int initialPeriodValue;

  /// Изначальный тип периода
  final PeriodType initialPeriodType;

  /// Событие изменения значения периода привычки
  final Function(int periodValue) onPeriodValueChange;

  /// Событие изменения типа периода привычки
  final Function(PeriodType periodType) onPeriodTypeChange;

  /// Создает инпут
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

    /// Кидаем событие измененного значения периода
    habitPeriodValueTEC.addListener(() {
      if (habitPeriodValueTEC.text.isNotEmpty) {
        widget.onPeriodValueChange(periodValue);
      }
    });

    periodType = widget.initialPeriodType;
  }

  @override
  Widget build(BuildContext context) => Row(
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

              /// Кидаем событие измененного типа привычки
              widget.onPeriodTypeChange(this.periodType);
            },
          ),
        )
      ],
    );
}

/// Инпут начала недели привычки
class HabitWeekStartInput extends StatefulWidget {
  /// Изначальное начало недели
  final Weekday initialWeekStart;

  /// Событие изменения начала недели
  final Function(Weekday weekStart) onWeekStartChange;

  /// Создает инпут
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
  Widget build(BuildContext context) => DropdownButtonFormField<Weekday>(
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

/// Инпут времени привычки
class HabitStartTimeInput extends StatefulWidget {
  /// Начальное время старта
  final DateTime initialStartTime;

  /// Событие изменения времени привычки
  final Function(DateTime time) onStartTimeChange;

  /// Создает инпут
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
        decoration: InputDecoration(labelText: "Время"),
        readOnly: true,
        onTap: () async {
          var selectedTime = await showTimePicker(
            context: context,
            helpText: "В какое время делать привычку?",
            cancelText: "Отмена",
            confirmText: "Ок",
            initialTime: TimeOfDay.fromDateTime(widget.initialStartTime),
          );
          if (selectedTime != null) {
            controller.text = selectedTime.format(context);

            /// Кидаем событие изменения времени привычки
            widget.onStartTimeChange(
              FixedDateTime.fromTimeOfDay(selectedTime).value,
            );
          }
        },
      );
}

/// Инпут места привычки
class HabitPlaceInput extends StatefulWidget {
  /// Событие изменения шаблона места, по которому предлагается автокомплит
  final Future<List<String>> Function(String placePattern) onPlacePatternChange;

  /// Событие изменения места привычки
  final Function(String place) onPlaceChange;

  /// Начальное место
  final String initialPlace;

  /// Создает инпут
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

    /// Кидаем событие изменения места привычки
    controller.addListener(() => widget.onPlaceChange(controller.text));
  }

  @override
  Widget build(BuildContext context) => TypeAheadFormField<String>(
      textFieldConfiguration: TextFieldConfiguration<String>(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Место",
          hintText: "В каком месте делать привычку?",
        ),
      ),
      // initialValue: this.controller.text,
      hideOnEmpty: true,
      hideOnLoading: true,
      hideSuggestionsOnKeyboardHide: false,
      onSuggestionSelected: (suggestion) => controller.text = suggestion,
      suggestionsCallback: (pattern) => widget.onPlacePatternChange(pattern),
      itemBuilder: (context, suggestion) => ListTile(
        title: Text(suggestion),
      ),
    );
}
