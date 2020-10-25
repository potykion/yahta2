// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$HabitTearOff {
  const _$HabitTearOff();

// ignore: unused_element
  _Habit call(
      {int id,
      @required String title,
      @required DateTime startTime,
      @required String place,
      int frequency = 1,
      int periodValue = 1,
      PeriodType periodType = PeriodType.days,
      Weekday weekStart = Weekday.monday}) {
    return _Habit(
      id: id,
      title: title,
      startTime: startTime,
      place: place,
      frequency: frequency,
      periodValue: periodValue,
      periodType: periodType,
      weekStart: weekStart,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Habit = _$HabitTearOff();

/// @nodoc
mixin _$Habit {
  /// Айди
  int get id;

  /// Название
  String get title;

  /// В какое время делать привычку
  DateTime get startTime;

  /// В каком месте делать привычку
  String get place;

  /// Как часто делать привычку (1 раз в день, 2 раза в день, ...)
  int get frequency;

  /// Значение периода (1 раз в день, 1 раз в 2 дня, ...)
  int get periodValue;

  /// Тип периода (1 раз в день, 1 раз в неделю, ...)
  PeriodType get periodType;

  /// Начало недели - для еженедельных привычек
  Weekday get weekStart;

  $HabitCopyWith<Habit> get copyWith;
}

/// @nodoc
abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      DateTime startTime,
      String place,
      int frequency,
      int periodValue,
      PeriodType periodType,
      Weekday weekStart});
}

/// @nodoc
class _$HabitCopyWithImpl<$Res> implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._value, this._then);

  final Habit _value;
  // ignore: unused_field
  final $Res Function(Habit) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object startTime = freezed,
    Object place = freezed,
    Object frequency = freezed,
    Object periodValue = freezed,
    Object periodType = freezed,
    Object weekStart = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      startTime:
          startTime == freezed ? _value.startTime : startTime as DateTime,
      place: place == freezed ? _value.place : place as String,
      frequency: frequency == freezed ? _value.frequency : frequency as int,
      periodValue:
          periodValue == freezed ? _value.periodValue : periodValue as int,
      periodType:
          periodType == freezed ? _value.periodType : periodType as PeriodType,
      weekStart: weekStart == freezed ? _value.weekStart : weekStart as Weekday,
    ));
  }
}

/// @nodoc
abstract class _$HabitCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$HabitCopyWith(_Habit value, $Res Function(_Habit) then) =
      __$HabitCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      DateTime startTime,
      String place,
      int frequency,
      int periodValue,
      PeriodType periodType,
      Weekday weekStart});
}

/// @nodoc
class __$HabitCopyWithImpl<$Res> extends _$HabitCopyWithImpl<$Res>
    implements _$HabitCopyWith<$Res> {
  __$HabitCopyWithImpl(_Habit _value, $Res Function(_Habit) _then)
      : super(_value, (v) => _then(v as _Habit));

  @override
  _Habit get _value => super._value as _Habit;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object startTime = freezed,
    Object place = freezed,
    Object frequency = freezed,
    Object periodValue = freezed,
    Object periodType = freezed,
    Object weekStart = freezed,
  }) {
    return _then(_Habit(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      startTime:
          startTime == freezed ? _value.startTime : startTime as DateTime,
      place: place == freezed ? _value.place : place as String,
      frequency: frequency == freezed ? _value.frequency : frequency as int,
      periodValue:
          periodValue == freezed ? _value.periodValue : periodValue as int,
      periodType:
          periodType == freezed ? _value.periodType : periodType as PeriodType,
      weekStart: weekStart == freezed ? _value.weekStart : weekStart as Weekday,
    ));
  }
}

/// @nodoc
class _$_Habit with DiagnosticableTreeMixin implements _Habit {
  _$_Habit(
      {this.id,
      @required this.title,
      @required this.startTime,
      @required this.place,
      this.frequency = 1,
      this.periodValue = 1,
      this.periodType = PeriodType.days,
      this.weekStart = Weekday.monday})
      : assert(title != null),
        assert(startTime != null),
        assert(place != null),
        assert(frequency != null),
        assert(periodValue != null),
        assert(periodType != null),
        assert(weekStart != null);

  @override

  /// Айди
  final int id;
  @override

  /// Название
  final String title;
  @override

  /// В какое время делать привычку
  final DateTime startTime;
  @override

  /// В каком месте делать привычку
  final String place;
  @JsonKey(defaultValue: 1)
  @override

  /// Как часто делать привычку (1 раз в день, 2 раза в день, ...)
  final int frequency;
  @JsonKey(defaultValue: 1)
  @override

  /// Значение периода (1 раз в день, 1 раз в 2 дня, ...)
  final int periodValue;
  @JsonKey(defaultValue: PeriodType.days)
  @override

  /// Тип периода (1 раз в день, 1 раз в неделю, ...)
  final PeriodType periodType;
  @JsonKey(defaultValue: Weekday.monday)
  @override

  /// Начало недели - для еженедельных привычек
  final Weekday weekStart;

  bool _diddateRange = false;
  DateRange _dateRange;

  @override
  DateRange get dateRange {
    if (_diddateRange == false) {
      _diddateRange = true;
      _dateRange = this.periodType == PeriodType.days
          ? DayDateRange(value: this.periodValue)
          : this.periodType == PeriodType.weeks
              ? WeekDateRange(
                  weekStartDay: this.weekStart, value: this.periodValue)
              : MonthDateRange(value: this.periodValue);
    }
    return _dateRange;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Habit(id: $id, title: $title, startTime: $startTime, place: $place, frequency: $frequency, periodValue: $periodValue, periodType: $periodType, weekStart: $weekStart, dateRange: $dateRange)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Habit'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('place', place))
      ..add(DiagnosticsProperty('frequency', frequency))
      ..add(DiagnosticsProperty('periodValue', periodValue))
      ..add(DiagnosticsProperty('periodType', periodType))
      ..add(DiagnosticsProperty('weekStart', weekStart))
      ..add(DiagnosticsProperty('dateRange', dateRange));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Habit &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.startTime, startTime) ||
                const DeepCollectionEquality()
                    .equals(other.startTime, startTime)) &&
            (identical(other.place, place) ||
                const DeepCollectionEquality().equals(other.place, place)) &&
            (identical(other.frequency, frequency) ||
                const DeepCollectionEquality()
                    .equals(other.frequency, frequency)) &&
            (identical(other.periodValue, periodValue) ||
                const DeepCollectionEquality()
                    .equals(other.periodValue, periodValue)) &&
            (identical(other.periodType, periodType) ||
                const DeepCollectionEquality()
                    .equals(other.periodType, periodType)) &&
            (identical(other.weekStart, weekStart) ||
                const DeepCollectionEquality()
                    .equals(other.weekStart, weekStart)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(startTime) ^
      const DeepCollectionEquality().hash(place) ^
      const DeepCollectionEquality().hash(frequency) ^
      const DeepCollectionEquality().hash(periodValue) ^
      const DeepCollectionEquality().hash(periodType) ^
      const DeepCollectionEquality().hash(weekStart);

  @override
  _$HabitCopyWith<_Habit> get copyWith =>
      __$HabitCopyWithImpl<_Habit>(this, _$identity);
}

abstract class _Habit implements Habit {
  factory _Habit(
      {int id,
      @required String title,
      @required DateTime startTime,
      @required String place,
      int frequency,
      int periodValue,
      PeriodType periodType,
      Weekday weekStart}) = _$_Habit;

  @override

  /// Айди
  int get id;
  @override

  /// Название
  String get title;
  @override

  /// В какое время делать привычку
  DateTime get startTime;
  @override

  /// В каком месте делать привычку
  String get place;
  @override

  /// Как часто делать привычку (1 раз в день, 2 раза в день, ...)
  int get frequency;
  @override

  /// Значение периода (1 раз в день, 1 раз в 2 дня, ...)
  int get periodValue;
  @override

  /// Тип периода (1 раз в день, 1 раз в неделю, ...)
  PeriodType get periodType;
  @override

  /// Начало недели - для еженедельных привычек
  Weekday get weekStart;
  @override
  _$HabitCopyWith<_Habit> get copyWith;
}

/// @nodoc
class _$HabitMarkTearOff {
  const _$HabitMarkTearOff();

// ignore: unused_element
  _HabitMark call({int id, @required int habitId, @required DateTime created}) {
    return _HabitMark(
      id: id,
      habitId: habitId,
      created: created,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $HabitMark = _$HabitMarkTearOff();

/// @nodoc
mixin _$HabitMark {
  int get id;
  int get habitId;
  DateTime get created;

  $HabitMarkCopyWith<HabitMark> get copyWith;
}

/// @nodoc
abstract class $HabitMarkCopyWith<$Res> {
  factory $HabitMarkCopyWith(HabitMark value, $Res Function(HabitMark) then) =
      _$HabitMarkCopyWithImpl<$Res>;
  $Res call({int id, int habitId, DateTime created});
}

/// @nodoc
class _$HabitMarkCopyWithImpl<$Res> implements $HabitMarkCopyWith<$Res> {
  _$HabitMarkCopyWithImpl(this._value, this._then);

  final HabitMark _value;
  // ignore: unused_field
  final $Res Function(HabitMark) _then;

  @override
  $Res call({
    Object id = freezed,
    Object habitId = freezed,
    Object created = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      habitId: habitId == freezed ? _value.habitId : habitId as int,
      created: created == freezed ? _value.created : created as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$HabitMarkCopyWith<$Res> implements $HabitMarkCopyWith<$Res> {
  factory _$HabitMarkCopyWith(
          _HabitMark value, $Res Function(_HabitMark) then) =
      __$HabitMarkCopyWithImpl<$Res>;
  @override
  $Res call({int id, int habitId, DateTime created});
}

/// @nodoc
class __$HabitMarkCopyWithImpl<$Res> extends _$HabitMarkCopyWithImpl<$Res>
    implements _$HabitMarkCopyWith<$Res> {
  __$HabitMarkCopyWithImpl(_HabitMark _value, $Res Function(_HabitMark) _then)
      : super(_value, (v) => _then(v as _HabitMark));

  @override
  _HabitMark get _value => super._value as _HabitMark;

  @override
  $Res call({
    Object id = freezed,
    Object habitId = freezed,
    Object created = freezed,
  }) {
    return _then(_HabitMark(
      id: id == freezed ? _value.id : id as int,
      habitId: habitId == freezed ? _value.habitId : habitId as int,
      created: created == freezed ? _value.created : created as DateTime,
    ));
  }
}

/// @nodoc
class _$_HabitMark with DiagnosticableTreeMixin implements _HabitMark {
  _$_HabitMark({this.id, @required this.habitId, @required this.created})
      : assert(habitId != null),
        assert(created != null);

  @override
  final int id;
  @override
  final int habitId;
  @override
  final DateTime created;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HabitMark(id: $id, habitId: $habitId, created: $created)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HabitMark'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('habitId', habitId))
      ..add(DiagnosticsProperty('created', created));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HabitMark &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.habitId, habitId) ||
                const DeepCollectionEquality()
                    .equals(other.habitId, habitId)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality().equals(other.created, created)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(habitId) ^
      const DeepCollectionEquality().hash(created);

  @override
  _$HabitMarkCopyWith<_HabitMark> get copyWith =>
      __$HabitMarkCopyWithImpl<_HabitMark>(this, _$identity);
}

abstract class _HabitMark implements HabitMark {
  factory _HabitMark(
      {int id,
      @required int habitId,
      @required DateTime created}) = _$_HabitMark;

  @override
  int get id;
  @override
  int get habitId;
  @override
  DateTime get created;
  @override
  _$HabitMarkCopyWith<_HabitMark> get copyWith;
}
