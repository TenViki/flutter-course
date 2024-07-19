// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Telemetry _$TelemetryFromJson(Map<String, dynamic> json) {
  return _Telemetry.fromJson(json);
}

/// @nodoc
mixin _$Telemetry {
  int get telemetryId => throw _privateConstructorUsedError;
  int get altitude => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  int get temperature => throw _privateConstructorUsedError;
  int get velocity => throw _privateConstructorUsedError;
  int get radiation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelemetryCopyWith<Telemetry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelemetryCopyWith<$Res> {
  factory $TelemetryCopyWith(Telemetry value, $Res Function(Telemetry) then) =
      _$TelemetryCopyWithImpl<$Res, Telemetry>;
  @useResult
  $Res call(
      {int telemetryId,
      int altitude,
      int timestamp,
      int temperature,
      int velocity,
      int radiation});
}

/// @nodoc
class _$TelemetryCopyWithImpl<$Res, $Val extends Telemetry>
    implements $TelemetryCopyWith<$Res> {
  _$TelemetryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telemetryId = null,
    Object? altitude = null,
    Object? timestamp = null,
    Object? temperature = null,
    Object? velocity = null,
    Object? radiation = null,
  }) {
    return _then(_value.copyWith(
      telemetryId: null == telemetryId
          ? _value.telemetryId
          : telemetryId // ignore: cast_nullable_to_non_nullable
              as int,
      altitude: null == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as int,
      velocity: null == velocity
          ? _value.velocity
          : velocity // ignore: cast_nullable_to_non_nullable
              as int,
      radiation: null == radiation
          ? _value.radiation
          : radiation // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TelemetryImplCopyWith<$Res>
    implements $TelemetryCopyWith<$Res> {
  factory _$$TelemetryImplCopyWith(
          _$TelemetryImpl value, $Res Function(_$TelemetryImpl) then) =
      __$$TelemetryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int telemetryId,
      int altitude,
      int timestamp,
      int temperature,
      int velocity,
      int radiation});
}

/// @nodoc
class __$$TelemetryImplCopyWithImpl<$Res>
    extends _$TelemetryCopyWithImpl<$Res, _$TelemetryImpl>
    implements _$$TelemetryImplCopyWith<$Res> {
  __$$TelemetryImplCopyWithImpl(
      _$TelemetryImpl _value, $Res Function(_$TelemetryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telemetryId = null,
    Object? altitude = null,
    Object? timestamp = null,
    Object? temperature = null,
    Object? velocity = null,
    Object? radiation = null,
  }) {
    return _then(_$TelemetryImpl(
      telemetryId: null == telemetryId
          ? _value.telemetryId
          : telemetryId // ignore: cast_nullable_to_non_nullable
              as int,
      altitude: null == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as int,
      velocity: null == velocity
          ? _value.velocity
          : velocity // ignore: cast_nullable_to_non_nullable
              as int,
      radiation: null == radiation
          ? _value.radiation
          : radiation // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TelemetryImpl implements _Telemetry {
  const _$TelemetryImpl(
      {required this.telemetryId,
      required this.altitude,
      required this.timestamp,
      required this.temperature,
      required this.velocity,
      required this.radiation});

  factory _$TelemetryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TelemetryImplFromJson(json);

  @override
  final int telemetryId;
  @override
  final int altitude;
  @override
  final int timestamp;
  @override
  final int temperature;
  @override
  final int velocity;
  @override
  final int radiation;

  @override
  String toString() {
    return 'Telemetry(telemetryId: $telemetryId, altitude: $altitude, timestamp: $timestamp, temperature: $temperature, velocity: $velocity, radiation: $radiation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelemetryImpl &&
            (identical(other.telemetryId, telemetryId) ||
                other.telemetryId == telemetryId) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.velocity, velocity) ||
                other.velocity == velocity) &&
            (identical(other.radiation, radiation) ||
                other.radiation == radiation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, telemetryId, altitude, timestamp,
      temperature, velocity, radiation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TelemetryImplCopyWith<_$TelemetryImpl> get copyWith =>
      __$$TelemetryImplCopyWithImpl<_$TelemetryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TelemetryImplToJson(
      this,
    );
  }
}

abstract class _Telemetry implements Telemetry {
  const factory _Telemetry(
      {required final int telemetryId,
      required final int altitude,
      required final int timestamp,
      required final int temperature,
      required final int velocity,
      required final int radiation}) = _$TelemetryImpl;

  factory _Telemetry.fromJson(Map<String, dynamic> json) =
      _$TelemetryImpl.fromJson;

  @override
  int get telemetryId;
  @override
  int get altitude;
  @override
  int get timestamp;
  @override
  int get temperature;
  @override
  int get velocity;
  @override
  int get radiation;
  @override
  @JsonKey(ignore: true)
  _$$TelemetryImplCopyWith<_$TelemetryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
