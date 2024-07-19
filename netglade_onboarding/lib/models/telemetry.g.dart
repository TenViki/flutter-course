// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelemetryImpl _$$TelemetryImplFromJson(Map<String, dynamic> json) =>
    _$TelemetryImpl(
      telemetryId: (json['telemetryId'] as num).toInt(),
      altitude: (json['altitude'] as num).toInt(),
      timestamp: (json['timestamp'] as num).toInt(),
      temperature: (json['temperature'] as num).toInt(),
      velocity: (json['velocity'] as num).toInt(),
      radiation: (json['radiation'] as num).toInt(),
    );

Map<String, dynamic> _$$TelemetryImplToJson(_$TelemetryImpl instance) =>
    <String, dynamic>{
      'telemetryId': instance.telemetryId,
      'altitude': instance.altitude,
      'timestamp': instance.timestamp,
      'temperature': instance.temperature,
      'velocity': instance.velocity,
      'radiation': instance.radiation,
    };
