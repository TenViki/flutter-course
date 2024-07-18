class SatelliteTelemetry {
  final int telemetryId;
  final int altitude;
  final int timestamp;
  final int temperature;
  final int velocity;
  final int radiation;

  const SatelliteTelemetry({
    required this.telemetryId,
    required this.altitude,
    required this.timestamp,
    required this.temperature,
    required this.velocity,
    required this.radiation,
  });
  factory SatelliteTelemetry.fromJson(Map<String, dynamic> json) {
    return SatelliteTelemetry(
        telemetryId: json['telemetryId'] as int,
        altitude: json['altitude'] as int,
        timestamp: json['timestamp'] as int,
        temperature: json['temperature'] as int,
        velocity: json['velocity']as int,
        radiation: json['radiation'] as int,);
  }
}
