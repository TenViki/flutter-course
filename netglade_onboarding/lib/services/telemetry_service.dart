import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/models/telemetry.dart';
import "package:netglade_onboarding/providers.dart";
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "telemetry_service.g.dart";

class TelemetryState extends Equatable {
  const TelemetryState();

  @override
  List<Object> get props => [];
}

class TelemetryLoading extends TelemetryState {}

class TelemetryData extends TelemetryState {
  final List<Telemetry> telemetry;

  const TelemetryData(this.telemetry);

  @override
  List<Object> get props => [telemetry];
}

@riverpod
class TelemetryService extends _$TelemetryService {
  DateTime? startDate;
  DateTime? endDate;
  int? minAltitude;
  int? maxAltitude;

  @override
  TelemetryState build() {
    print("Building telemetry service");
    updateTelemetry();
    final timer = Timer.periodic(
      const Duration(seconds: 10),
      (t) => updateTelemetry(),
    );

    ref.onDispose(timer.cancel);

    return TelemetryLoading();
  }

  Future<void> updateTelemetry() async {
    print("Updating telemetry");
    final telemetryRepository = ref.read(telemetryRepositoryProvider);
    final authState = ref.read(authServiceProvider);

    if (authState is! AuthAuthenticated) {
      return;
    }

    print("$startDate, $endDate, $minAltitude, $maxAltitude");

    final telemetry = await telemetryRepository.retrieveTelemetry(
        authState.token, startDate, endDate, minAltitude, maxAltitude);

    print(telemetry);

    state = TelemetryData(telemetry);
  }

  void setStartDate(DateTime? date) {
    print("Setting start date");
    startDate = date;
    updateTelemetry();
  }

  void setEndDate(DateTime? date) {
    endDate = date;
    updateTelemetry();
  }

  void setMinAltitude(int? altitude) {
    minAltitude = altitude;
    updateTelemetry();
  }

  void setMaxAltitude(int? altitude) {
    maxAltitude = altitude;
    updateTelemetry();
  }
}
