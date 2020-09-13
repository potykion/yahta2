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


  @override
  Widget build(context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Container()
        ),
      );
}
