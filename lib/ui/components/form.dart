import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/models.dart';

class HabitFormCard extends StatefulWidget {
  final int id;
  final String title;
  final HabitFrequency frequency;

  const HabitFormCard({Key key, this.id, this.title, this.frequency})
      : super(key: key);

  @override
  _HabitFormCardState createState() => _HabitFormCardState();
}

class _HabitFormCardState extends State<HabitFormCard> {
  TextEditingController controller = TextEditingController();
  int selectedFrequencyIndex = HabitFrequency.daily.index;

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      controller.text = widget.title;
    }
    if (widget.frequency != null) {
      selectedFrequencyIndex = widget.frequency.index;
    }
  }

  @override
  void didUpdateWidget(HabitFormCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.title != null) {
      controller.text = widget.title;
    }
    if (widget.frequency != null) {
      selectedFrequencyIndex = widget.frequency.index;
    }
  }

  get selectedFrequency => HabitFrequency.values[this.selectedFrequencyIndex];

  @override
  Widget build(context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: SizedBox.expand(
            // height: 50,
            child: DraggableScrollableSheet(
              initialChildSize: 0.25,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ListView(
                  controller: scrollController,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300], width: 2.5),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          width: 30,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(hintText: "Чем займешься?"),
                            controller: controller,
                            autofocus: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            context.bloc<HabitBloc>().add(
                                  widget.id != null
                                      ? HabitUpdated(
                                          id: widget.id,
                                          title: controller.text,
                                          frequency: selectedFrequency,
                                        )
                                      : HabitCreated(
                                          title: controller.text,
                                          frequency: selectedFrequency,
                                        ),
                                );
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    Wrap(
                      spacing: 25,
                      children: List.generate(
                        HabitFrequency.values.length,
                        (index) => ChoiceChip(
                          label:
                              Text(HabitFrequency.values[index].toVerboseStr()),
                          onSelected: (selected) => setState(
                              () => this.selectedFrequencyIndex = index),
                          selected: selectedFrequencyIndex == index,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );
}
