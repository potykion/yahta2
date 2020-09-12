import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahta2/logic/habit/blocs.dart';
import 'package:yahta2/logic/habit/view_models.dart';

import 'form.dart';

enum HabitAction { edit, delete }

class HabitListTile extends StatelessWidget {
  final HabitVM habit;

  const HabitListTile({Key key, this.habit}) : super(key: key);

  @override
  Widget build(context) => Dismissible(
        key: Key(habit.id.toString()),
        child: ListTile(
          title: Text(
            habit.title,
            style: TextStyle(
              decoration: habit.done ? TextDecoration.lineThrough : null,
              color: habit.done ? Colors.grey : null,
              fontWeight: !habit.done && habit.timeToPerformHabit
                  ? FontWeight.bold
                  : null,
            ),
          ),
          trailing: PopupMenuButton<HabitAction>(
            onSelected: (action) {
              if (action == HabitAction.delete) {
                context.bloc<HabitBloc>().add(HabitDeleted(habit.id));
              } else if (action == HabitAction.edit) {
                Scaffold.of(context).showBottomSheet(
                  (_) => HabitFormCard(
                    id: habit.id,
                    title: habit.title,
                    frequency: habit.frequency,
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<HabitAction>>[
              const PopupMenuItem<HabitAction>(
                value: HabitAction.edit,
                child: Text('Изменить'),
              ),
              const PopupMenuItem<HabitAction>(
                value: HabitAction.delete,
                child: Text('Удалить'),
              ),
            ],
          ),
        ),
        direction: habit.done
            ? DismissDirection.startToEnd
            : DismissDirection.endToStart,
        confirmDismiss: (DismissDirection dir) async {
          var event;
          if (dir == DismissDirection.endToStart) {
            var player = AudioCache();
            var sounds = [
              "sport_badminton_racket_fast_movement_swoosh_002.mp3",
              "sport_badminton_racket_fast_movement_swoosh_003.mp3",
              "sport_badminton_racket_fast_movement_swoosh_006.mp3",
            ];
            var random = new Random();
            player.play(sounds[random.nextInt(sounds.length)], mode: PlayerMode.LOW_LATENCY);

            event = HabitDone(habit.id);
          } else {
            event = dir == DismissDirection.startToEnd
                  ? HabitUndone(
                      habitId: habit.id,
                      habitFrequency: habit.frequency,
                    )
                  : null;
          }
          context.bloc<HabitBloc>().add(event);

          return false;
        },
      );
}
