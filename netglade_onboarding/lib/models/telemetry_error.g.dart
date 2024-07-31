// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelemetryErrorImpl _$$TelemetryErrorImplFromJson(Map<String, dynamic> json) =>
    _$TelemetryErrorImpl(
      id: (json['id'] as num).toInt(),
      errorData: json['errorData'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$$TelemetryErrorImplToJson(
        _$TelemetryErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'errorData': instance.errorData,
      'timestamp': instance.timestamp,
    };
