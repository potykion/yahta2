import 'package:bloc/bloc.dart';
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

  HabitUpdated({this.id, this.title});
}

class HabitDeleted extends HabitEvent {
  final int habitId;

  HabitDeleted(this.habitId);
}

class HabitDone extends HabitEvent {
  final int habitId;

  HabitDone(this.habitId);
}

class HabitCreated extends HabitEvent {
  final String title;
  final HabitFrequency frequency;

  HabitCreated({this.title, this.frequency});
}

class HabitsLoadStarted extends HabitEvent {}

class HabitState {
  final List<Habit> habits;
  final List<HabitMark> habitMarks;

  HabitState({this.habits = const [], this.habitMarks = const []});

  Map<int, HabitMark> get idHabitMarks =>
      Map.fromEntries(habitMarks.map((hm) => MapEntry(hm.habitId, hm)));

  List<Habit> get orderedHabits =>
      (habits.toList()..sort((h1, h2) => h1.order.compareTo(h2.order)));

  List<HabitVM> get habitVMs => orderedHabits
      .map(
        (h) => HabitVM(
          id: h.id,
          title: h.title,
          order: h.order,
          done: idHabitMarks.containsKey(h.id),
        ),
      )
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
        await _repo.insertHabit(
          Habit(title: event.title, frequency: event.frequency),
        ),
      ]);
    } else if (event is HabitDone) {
      yield state.copyWith(habitMarks: [
        ...state.habitMarks,
        await _repo.insertHabitMark(
            HabitMark(habitId: event.habitId, created: DateTime.now())),
      ]);
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
            state.habits
                .where((h) => h.id == event.id)
                .first
                .copyWith(title: event.title),
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
