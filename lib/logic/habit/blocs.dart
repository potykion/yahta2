import 'package:bloc/bloc.dart';
import 'package:yahta2/logic/habit/db.dart';

import 'models.dart';

class HabitEvent {}

class HabitCreated extends HabitEvent {
  final String title;

  HabitCreated(this.title);
}

class HabitsLoadStarted extends HabitEvent {}

class HabitState {
  final List<Habit> habits;

  HabitState({this.habits = const []});

  copyWith({List<Habit> habits}) => HabitState(
        habits: habits ?? this.habits,
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
        habits: await this._repo.listHabits(),
      );
    } else if (event is HabitCreated) {
      yield state.copyWith(habits: [
        ...state.habits,
        await _repo.insertHabit(Habit(title: event.title)),
      ]);
    }
  }
}
