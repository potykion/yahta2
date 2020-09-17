import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

import 'package:yahta2/logic/habit/db.dart';
import 'package:yahta2/logic/habit/utils.dart';
import 'package:yahta2/logic/habit/view_models.dart';

import 'models.dart';

class HabitEvent {}

class HabitReordered extends HabitEvent {
  final int oldIndex;
  final int newIndex;

  HabitReordered(this.oldIndex, this.newIndex);
}

class HabitUpdated extends HabitEvent {
  final int id;
  final String title;
  final int frequency;
  final int periodValue;
  final PeriodType periodType;
  final Weekday weekStart;

  HabitUpdated({
    this.id,
    this.title,
    this.frequency,
    this.periodValue,
    this.periodType,
    this.weekStart,
  });

  Habit updateHabit(Habit habit) {
    return habit.copyWith(
      title: title,
      frequency: frequency,
      periodValue: periodValue,
      periodType: periodType,
      weekStart: weekStart,
    );
  }
}

class HabitDeleted extends HabitEvent {
  final int habitId;

  HabitDeleted(this.habitId);
}

class HabitDone extends HabitEvent {
  final Habit habit;

  HabitDone(this.habit);
}

class HabitUndone extends HabitEvent {
  final Habit habit;

  HabitUndone(this.habit);
}

class HabitCreated extends HabitEvent {
  final String title;
  final int order;
  final int frequency;
  final int periodValue;
  final PeriodType periodType;
  final Weekday weekStart;

  HabitCreated({
    this.title,
    this.order,
    this.frequency,
    this.periodValue,
    this.periodType,
    this.weekStart,
  });

  Habit toHabit() {
    return Habit(
      periodValue: this.periodValue,
      periodType: this.periodType,
      order: this.order,
      title: this.title,
      frequency: this.frequency,
    );
  }
}

class HabitsLoadStarted extends HabitEvent {}

class HabitState {
  final List<Habit> habits;
  final List<HabitMark> habitMarks;

  HabitState({this.habits = const [], this.habitMarks = const []});

  Map<int, List<HabitMark>> get idHabitMarks =>
      groupBy(habitMarks, (HabitMark hm) => hm.habitId);

  List<Habit> get orderedHabits =>
      (habits.toList()..sort((h1, h2) => h1.order.compareTo(h2.order)));

  List<HabitVM> get habitVMs => orderedHabits
      .map((h) => HabitVM.build(h, idHabitMarks[h.id] ?? []))
      .toList();

  copyWith({List<Habit> habits, List<HabitMark> habitMarks}) => HabitState(
        habits: habits ?? this.habits,
        habitMarks: habitMarks ?? this.habitMarks,
      );
}

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository _repo;

  HabitBloc(this._repo);

  @override
  HabitState get initialState => HabitState();

  @override
  Stream<HabitState> mapEventToState(HabitEvent event) async* {
    if (event is HabitsLoadStarted) {
      yield state.copyWith(
        habits: await _repo.listHabits(),
        habitMarks: await _repo.listHabitMarksDependingOnFreq(),
      );
    } else if (event is HabitCreated) {
      yield state.copyWith(habits: [
        ...state.habits,
        await _repo.insertHabit(event.toHabit()),
      ]);
    } else if (event is HabitDone) {
      var sounds = [
        "sport_badminton_racket_fast_movement_swoosh_002.mp3",
        "sport_badminton_racket_fast_movement_swoosh_003.mp3",
        "sport_badminton_racket_fast_movement_swoosh_006.mp3",
      ];
      AudioCache().play(
        sounds[new Random().nextInt(sounds.length)],
        mode: PlayerMode.LOW_LATENCY,
      );
      yield state.copyWith(habitMarks: [
        ...state.habitMarks,
        await _repo.insertHabitMark(
            HabitMark(habitId: event.habit.id, created: DateTime.now())),
      ]);
    } else if (event is HabitUndone) {
      var sounds = [
        "zapsplat_warfare_knife_blade_draw_004_23989.mp3",
        "zapsplat_warfare_knife_blade_draw_005_23990.mp3",
        "zapsplat_warfare_knife_blade_draw_008_23993.mp3",
      ];
      AudioCache().play(
        sounds[new Random().nextInt(sounds.length)],
        mode: PlayerMode.LOW_LATENCY,
      );

      var habitMarkIdToDelete =
          (state.habitMarks.where((hm) => hm.habitId == event.habit.id).toList()
                ..sort((hm2, hm1) => hm1.created.compareTo(hm2.created)))
              .map((hm) => hm.id)
              .first;
      await _repo.deleteHabitMarks([habitMarkIdToDelete]);

      var habitMarksWithoutDeleted = state.habitMarks
        ..removeWhere((hm) => hm.id == habitMarkIdToDelete);

      yield state.copyWith(habitMarks: habitMarksWithoutDeleted);
    } else if (event is HabitDeleted) {
      await _repo.deleteHabitAndMarks(event.habitId);
      yield state.copyWith(
        habits: state.habits.where((h) => h.id != event.habitId).toList(),
        habitMarks: state.habitMarks
            .where((hm) => hm.habitId != event.habitId)
            .toList(),
      );
    } else if (event is HabitUpdated) {
      yield state.copyWith(
        habits: [
          ...state.habits.where((h) => h.id != event.id),
          await _repo.updateHabit(
            event.updateHabit(
              state.habits.where((h) => h.id == event.id).first,
            ),
          ),
        ],
      );
    } else if (event is HabitReordered) {
      var newHabits = reorderHabits(
        state.orderedHabits,
        event.oldIndex,
        event.newIndex,
      );
      await Future.wait(newHabits.map((h) => _repo.updateHabit(h)));
      yield state.copyWith(habits: newHabits);
    } else {
      throw "UNHANDLED EVENT: $event";
    }
  }
}
