import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:yahta2/logic/habit/db.dart';
import 'package:yahta2/logic/habit/view_models.dart';

import 'models.dart';

/// Базовое событие
class HabitEvent {}

/// Событие смены периода привычки (ежедневно > еженедельно)
class FilterPeriodTypeEvent extends HabitEvent {
  final PeriodType periodType;

  FilterPeriodTypeEvent(this.periodType);
}

/// Событие переключения видимости выполненных привычек
class ToggleShowDoneEvent extends HabitEvent {}

/// Событие обновления привычки
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

/// Событие удаления привычки
class HabitDeleted extends HabitEvent {
  final int habitId;

  HabitDeleted(this.habitId);
}

/// Событие выполнения привычки
class HabitDone extends HabitEvent {
  final Habit habit;

  HabitDone(this.habit);
}

/// Событие отмены выполнения привычки
class HabitUndone extends HabitEvent {
  final Habit habit;

  HabitUndone(this.habit);
}

/// Событие создания привычки
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

/// Событие начала загрузки списка привычек
class HabitsLoadStarted extends HabitEvent {}

/// Стейт привычек
/// todo как freezed класс
class HabitState {
  /// Привычки
  final List<Habit> habits;

  /// Отметки привычек
  final List<HabitMark> habitMarks;

  /// Показывать завершенные привычки
  final bool showDone;

  /// Фильтр привычек по периоду
  final PeriodType filterPeriodType;

  HabitState({
    this.habits = const [],
    this.habitMarks = const [],
    this.showDone = true,
    this.filterPeriodType = PeriodType.days,
  });

  /// Мапа, где ключ айди привычки, значение - список отметок
  Map<int, List<HabitMark>> get idHabitMarks =>
      groupBy(habitMarks, (HabitMark hm) => hm.habitId);

  /// Привычки, отсортированные по времени
  List<Habit> get sortedHabits =>
      (habits.toList()..sort((h1, h2) => h1.startTime.compareTo(h2.startTime)));

  /// Вью-модельки привычек, которые используются в списке привычек
  List<HabitVM> get habitVMs => sortedHabits
      .map((h) => HabitVM.build(h, idHabitMarks[h.id] ?? []))
      .toList();

  /// Вью-модельки, отфильтрованные по периоду + по завершенности, если такой флаг стоит
  List<HabitVM> get habitVMsToShow => habitVMs
      .where((HabitVM vm) => vm.habit.periodType == filterPeriodType)
      .where((vm) => showDone || !vm.done)
      .toList();

  /// Считает кол-во невыполненных привычек
  int countUndoneWithPeriodType(PeriodType periodType) => habitVMs
      .where((vm) => !vm.done && vm.habit.periodType == periodType)
      .length;

  /// Копирует состояние с новыми данными
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

/// Блок привычек
class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository habitRepo;
  final SettingsRepository settingsRepository;

  HabitBloc({this.habitRepo, this.settingsRepository});

  @override
  HabitState get initialState => HabitState();

  /// Обратывает событие, возвращая новое состояние
  @override
  Stream<HabitState> mapEventToState(HabitEvent event) async* {
    if (event is HabitsLoadStarted) {
      // Грузим привычки, отметки, флаг показа завершенных привычек
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
      // Создаем отметку
      yield state.copyWith(habits: [
        ...state.habits,
        await habitRepo.insertHabit(event.toHabit()),
      ]);
    } else if (event is HabitDone) {
      // Рандомно воспроизводим звук
      // todo вынести в сервис обработку евента + вынести воспроизведение звуков
      var sounds = [
        "sport_badminton_racket_fast_movement_swoosh_002.mp3",
        "sport_badminton_racket_fast_movement_swoosh_003.mp3",
        "sport_badminton_racket_fast_movement_swoosh_006.mp3",
      ];
      AudioCache().play(
        sounds[new Random().nextInt(sounds.length)],
        mode: PlayerMode.LOW_LATENCY,
      );

      // Создаем новую отметку
      yield state.copyWith(habitMarks: [
        ...state.habitMarks,
        await habitRepo.insertHabitMark(
            HabitMark(habitId: event.habit.id, created: DateTime.now())),
      ]);
    } else if (event is HabitUndone) {
      // Рандомно воспроизводим звук
      var sounds = [
        "zapsplat_warfare_knife_blade_draw_004_23989.mp3",
        "zapsplat_warfare_knife_blade_draw_005_23990.mp3",
        "zapsplat_warfare_knife_blade_draw_008_23993.mp3",
      ];
      AudioCache().play(
        sounds[new Random().nextInt(sounds.length)],
        mode: PlayerMode.LOW_LATENCY,
      );

      // Удаляем крайнюю отметку
      var habitMarkIdToDelete =
          (state.habitMarks.where((hm) => hm.habitId == event.habit.id).toList()
                ..sort((hm2, hm1) => hm1.created.compareTo(hm2.created)))
              .map((hm) => hm.id)
              .first;
      await habitRepo.deleteHabitMarks([habitMarkIdToDelete]);

      // Сеттим отметки без удаленной отметки
      var habitMarksWithoutDeleted = state.habitMarks
        ..removeWhere((hm) => hm.id == habitMarkIdToDelete);
      yield state.copyWith(habitMarks: habitMarksWithoutDeleted);
    } else if (event is HabitDeleted) {
      // Удаляем привычки и все ее отметки
      await habitRepo.deleteHabitAndMarks(event.habitId);
      yield state.copyWith(
        habits: state.habits.where((h) => h.id != event.habitId).toList(),
        habitMarks: state.habitMarks
            .where((hm) => hm.habitId != event.habitId)
            .toList(),
      );
    } else if (event is HabitUpdated) {
      // Обновляем привычку
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
      // Обновляем период, по которому фильтруем привычки
      yield state.copyWith(filterPeriodType: event.periodType);
    } else {
      throw "UNHANDLED EVENT: $event";
    }
  }
}
