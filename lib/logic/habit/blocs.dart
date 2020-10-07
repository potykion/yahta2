import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:yahta2/logic/habit/db.dart';
import 'package:yahta2/logic/habit/view_models.dart';

import 'models.dart';

class HabitEvent {}

class FilterPeriodTypeEvent extends HabitEvent {
  final PeriodType periodType;

  FilterPeriodTypeEvent(this.periodType);
}

class ToggleShowDoneEvent extends HabitEvent {}

class HabitUpdated extends HabitEvent {
  final int id;
  final String title;
  final int frequency;
  final int periodValue;
  final PeriodType periodType;
  final Weekday weekStart;
  final DateTime startTime;
  final String place;

  HabitUpdated({
    @required this.id,
    @required this.title,
    @required this.frequency,
    @required this.periodValue,
    @required this.periodType,
    @required this.weekStart,
    @required this.startTime,
    @required this.place,
  });

  Habit updateHabit(Habit habit) => habit.copyWith(
        title: title,
        frequency: frequency,
        periodValue: periodValue,
        periodType: periodType,
        weekStart: weekStart,
        startTime: startTime,
        place: place,
      );
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
  final int frequency;
  final int periodValue;
  final PeriodType periodType;
  final Weekday weekStart;
  final DateTime startTime;
  final String place;

  HabitCreated({
    @required this.title,
    @required this.frequency,
    @required this.periodValue,
    @required this.periodType,
    @required this.weekStart,
    @required this.startTime,
    @required this.place,
  });

  Habit toHabit() {
    return Habit(
      periodValue: this.periodValue,
      periodType: this.periodType,
      title: this.title,
      frequency: this.frequency,
      weekStart: this.weekStart,
      startTime: this.startTime,
      place: this.place,
    );
  }
}

class HabitsLoadStarted extends HabitEvent {}

class HabitState {
  final List<Habit> habits;
  final List<HabitMark> habitMarks;
  final bool showDone;
  final PeriodType filterPeriodType;

  HabitState({
    this.habits = const [],
    this.habitMarks = const [],
    this.showDone = true,
    this.filterPeriodType = PeriodType.days,
  });

  Map<int, List<HabitMark>> get idHabitMarks =>
      groupBy(habitMarks, (HabitMark hm) => hm.habitId);

  List<HabitVM> get habitVMs =>
      (habits.toList()..sort((h1, h2) => h1.startTime.compareTo(h2.startTime)))
          .where((h) => h.periodType == filterPeriodType)
          .map((h) => HabitVM.build(h, idHabitMarks[h.id] ?? []))
          .where((vm) => showDone || !vm.done)
          .toList();

  HabitState copyWith({
    List<Habit> habits,
    List<HabitMark> habitMarks,
    bool showDone,
    PeriodType filterPeriodType,
  }) =>
      HabitState(
        habits: habits ?? this.habits,
        habitMarks: habitMarks ?? this.habitMarks,
        showDone: showDone ?? this.showDone,
        filterPeriodType: filterPeriodType ?? this.filterPeriodType,
      );
}

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository habitRepo;
  final SettingsRepository settingsRepository;

  HabitBloc({this.habitRepo, this.settingsRepository});

  @override
  HabitState get initialState => HabitState();

  @override
  Stream<HabitState> mapEventToState(HabitEvent event) async* {
    if (event is HabitsLoadStarted) {
      yield state.copyWith(
        habits: await habitRepo.listHabits(),
        habitMarks: await habitRepo.listHabitMarksDependingOnFreq(),
        showDone: await settingsRepository.getShowDone(),
      );
    } else if (event is ToggleShowDoneEvent) {
      var newShowDone = !state.showDone;
      await settingsRepository.setShowDone(newShowDone);
      yield state.copyWith(showDone: newShowDone);
    } else if (event is HabitCreated) {
      yield state.copyWith(habits: [
        ...state.habits,
        await habitRepo.insertHabit(event.toHabit()),
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
        await habitRepo.insertHabitMark(
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
      await habitRepo.deleteHabitMarks([habitMarkIdToDelete]);

      var habitMarksWithoutDeleted = state.habitMarks
        ..removeWhere((hm) => hm.id == habitMarkIdToDelete);

      yield state.copyWith(habitMarks: habitMarksWithoutDeleted);
    } else if (event is HabitDeleted) {
      await habitRepo.deleteHabitAndMarks(event.habitId);
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
          await habitRepo.updateHabit(
            event.updateHabit(
              state.habits.where((h) => h.id == event.id).first,
            ),
          ),
        ],
      );
    } else if (event is FilterPeriodTypeEvent) {
      yield state.copyWith(filterPeriodType: event.periodType);
    } else {
      throw "UNHANDLED EVENT: $event";
    }
  }
}
