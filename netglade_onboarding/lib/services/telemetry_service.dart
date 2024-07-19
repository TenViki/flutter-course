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
  @override
  TelemetryState build() {
    final timer = Timer.periodic(
      const Duration(seconds: 10),
      (t) => updateTelemetry(),
    );

    ref.onDispose(timer.cancel);

    return TelemetryLoading();
  }

  Future<void> updateTelemetry() async {
    final telemetryRepository = ref.read(telemetryRepositoryProvider);
    final authState = ref.read(authServiceProvider);

    if (authState is! AuthAuthenticated) {
      return;
    }

    final telemetry =
        await telemetryRepository.retrieveTelemetry(authState.token);
    state = TelemetryData(telemetry);
  }
}
