// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$HabitTearOff {
  const _$HabitTearOff();

  _Habit call(
      {int id,
      @required String title,
      int order,
      int frequency = 1,
      int periodValue = 1,
      PeriodType periodType = PeriodType.days,
      Weekday weekStart = Weekday.monday}) {
    return _Habit(
      id: id,
      title: title,
      order: order,
      frequency: frequency,
      periodValue: periodValue,
      periodType: periodType,
      weekStart: weekStart,
    );
  }
}

// ignore: unused_element
const $Habit = _$HabitTearOff();

mixin _$Habit {
  int get id;
  String get title;
  int get order;
  int get frequency;
  int get periodValue;
  PeriodType get periodType;
  Weekday get weekStart;

  $HabitCopyWith<Habit> get copyWith;
}

abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      int order,
      int frequency,
      int periodValue,
      PeriodType periodType,
      Weekday weekStart});
}

class _$HabitCopyWithImpl<$Res> implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._value, this._then);

  final Habit _value;
  // ignore: unused_field
  final $Res Function(Habit) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object order = freezed,
    Object frequency = freezed,
    Object periodValue = freezed,
    Object periodType = freezed,
    Object weekStart = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      order: order == freezed ? _value.order : order as int,
      frequency: frequency == freezed ? _value.frequency : frequency as int,
      periodValue:
          periodValue == freezed ? _value.periodValue : periodValue as int,
      periodType:
          periodType == freezed ? _value.periodType : periodType as PeriodType,
      weekStart: weekStart == freezed ? _value.weekStart : weekStart as Weekday,
    ));
  }
}

abstract class _$HabitCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$HabitCopyWith(_Habit value, $Res Function(_Habit) then) =
      __$HabitCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      int order,
      int frequency,
      int periodValue,
      PeriodType periodType,
      Weekday weekStart});
}

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
    Object order = freezed,
    Object frequency = freezed,
    Object periodValue = freezed,
    Object periodType = freezed,
    Object weekStart = freezed,
  }) {
    return _then(_Habit(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      order: order == freezed ? _value.order : order as int,
      frequency: frequency == freezed ? _value.frequency : frequency as int,
      periodValue:
          periodValue == freezed ? _value.periodValue : periodValue as int,
      periodType:
          periodType == freezed ? _value.periodType : periodType as PeriodType,
      weekStart: weekStart == freezed ? _value.weekStart : weekStart as Weekday,
    ));
  }
}

class _$_Habit with DiagnosticableTreeMixin implements _Habit {
  _$_Habit(
      {this.id,
      @required this.title,
      this.order,
      this.frequency = 1,
      this.periodValue = 1,
      this.periodType = PeriodType.days,
      this.weekStart = Weekday.monday})
      : assert(title != null),
        assert(frequency != null),
        assert(periodValue != null),
        assert(periodType != null),
        assert(weekStart != null);

  @override
  final int id;
  @override
  final String title;
  @override
  final int order;
  @JsonKey(defaultValue: 1)
  @override
  final int frequency;
  @JsonKey(defaultValue: 1)
  @override
  final int periodValue;
  @JsonKey(defaultValue: PeriodType.days)
  @override
  final PeriodType periodType;
  @JsonKey(defaultValue: Weekday.monday)
  @override
  final Weekday weekStart;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Habit(id: $id, title: $title, order: $order, frequency: $frequency, periodValue: $periodValue, periodType: $periodType, weekStart: $weekStart)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Habit'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('order', order))
      ..add(DiagnosticsProperty('frequency', frequency))
      ..add(DiagnosticsProperty('periodValue', periodValue))
      ..add(DiagnosticsProperty('periodType', periodType))
      ..add(DiagnosticsProperty('weekStart', weekStart));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Habit &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
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
      const DeepCollectionEquality().hash(order) ^
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
      int order,
      int frequency,
      int periodValue,
      PeriodType periodType,
      Weekday weekStart}) = _$_Habit;

  @override
  int get id;
  @override
  String get title;
  @override
  int get order;
  @override
  int get frequency;
  @override
  int get periodValue;
  @override
  PeriodType get periodType;
  @override
  Weekday get weekStart;
  @override
  _$HabitCopyWith<_Habit> get copyWith;
}

class _$HabitMarkTearOff {
  const _$HabitMarkTearOff();

  _HabitMark call({int id, @required int habitId, @required DateTime created}) {
    return _HabitMark(
      id: id,
      habitId: habitId,
      created: created,
    );
  }
}

// ignore: unused_element
const $HabitMark = _$HabitMarkTearOff();

mixin _$HabitMark {
  int get id;
  int get habitId;
  DateTime get created;

  $HabitMarkCopyWith<HabitMark> get copyWith;
}

abstract class $HabitMarkCopyWith<$Res> {
  factory $HabitMarkCopyWith(HabitMark value, $Res Function(HabitMark) then) =
      _$HabitMarkCopyWithImpl<$Res>;
  $Res call({int id, int habitId, DateTime created});
}

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

abstract class _$HabitMarkCopyWith<$Res> implements $HabitMarkCopyWith<$Res> {
  factory _$HabitMarkCopyWith(
          _HabitMark value, $Res Function(_HabitMark) then) =
      __$HabitMarkCopyWithImpl<$Res>;
  @override
  $Res call({int id, int habitId, DateTime created});
}

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
