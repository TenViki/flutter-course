// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TelemetryError _$TelemetryErrorFromJson(Map<String, dynamic> json) {
  return _TelemetryError.fromJson(json);
}

/// @nodoc
mixin _$TelemetryError {
  int get id => throw _privateConstructorUsedError;
  String get errorData => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelemetryErrorCopyWith<TelemetryError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelemetryErrorCopyWith<$Res> {
  factory $TelemetryErrorCopyWith(
          TelemetryError value, $Res Function(TelemetryError) then) =
      _$TelemetryErrorCopyWithImpl<$Res, TelemetryError>;
  @useResult
  $Res call({int id, String errorData, int timestamp});
}

/// @nodoc
class _$TelemetryErrorCopyWithImpl<$Res, $Val extends TelemetryError>
    implements $TelemetryErrorCopyWith<$Res> {
  _$TelemetryErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? errorData = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      errorData: null == errorData
          ? _value.errorData
          : errorData // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TelemetryErrorImplCopyWith<$Res>
    implements $TelemetryErrorCopyWith<$Res> {
  factory _$$TelemetryErrorImplCopyWith(_$TelemetryErrorImpl value,
          $Res Function(_$TelemetryErrorImpl) then) =
      __$$TelemetryErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String errorData, int timestamp});
}

/// @nodoc
class __$$TelemetryErrorImplCopyWithImpl<$Res>
    extends _$TelemetryErrorCopyWithImpl<$Res, _$TelemetryErrorImpl>
    implements _$$TelemetryErrorImplCopyWith<$Res> {
  __$$TelemetryErrorImplCopyWithImpl(
      _$TelemetryErrorImpl _value, $Res Function(_$TelemetryErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? errorData = null,
    Object? timestamp = null,
  }) {
    return _then(_$TelemetryErrorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      errorData: null == errorData
          ? _value.errorData
          : errorData // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TelemetryErrorImpl implements _TelemetryError {
  const _$TelemetryErrorImpl(
      {required this.id, required this.errorData, required this.timestamp});

  factory _$TelemetryErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$TelemetryErrorImplFromJson(json);

  @override
  final int id;
  @override
  final String errorData;
  @override
  final int timestamp;

  @override
  String toString() {
    return 'TelemetryError(id: $id, errorData: $errorData, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelemetryErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.errorData, errorData) ||
                other.errorData == errorData) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, errorData, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TelemetryErrorImplCopyWith<_$TelemetryErrorImpl> get copyWith =>
      __$$TelemetryErrorImplCopyWithImpl<_$TelemetryErrorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TelemetryErrorImplToJson(
      this,
    );
  }
}

abstract class _TelemetryError implements TelemetryError {
  const factory _TelemetryError(
      {required final int id,
      required final String errorData,
      required final int timestamp}) = _$TelemetryErrorImpl;

  factory _TelemetryError.fromJson(Map<String, dynamic> json) =
      _$TelemetryErrorImpl.fromJson;

  @override
  int get id;
  @override
  String get errorData;
  @override
  int get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$TelemetryErrorImplCopyWith<_$TelemetryErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
