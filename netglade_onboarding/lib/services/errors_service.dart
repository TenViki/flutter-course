import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/models/telemetry_error.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "errors_service.g.dart";

sealed class TelemetryErrorState {}

class TelemetryErrorLoading extends TelemetryErrorState {}

class TelemetryErrorData extends TelemetryErrorState {
  final List<TelemetryError> errors;

  TelemetryErrorData(this.errors);
}

class TelemetryErrorError extends TelemetryErrorState {
  final String message;

  TelemetryErrorError(this.message);
}

@riverpod
class TelemetryErrorService extends _$TelemetryErrorService {
  @override
  TelemetryErrorState build() {
    return TelemetryErrorLoading();
  }

  Future<void> updateErrors() async {
    final authState = ref.watch(authServiceProvider);

    if (authState is! AuthAuthenticated) {
      return;
    }

    try {
      final errors =
          await ref.read(errorRepositoryProvider).getErrors(authState.token);
      state = TelemetryErrorData(errors);
    } catch (e) {
      state = TelemetryErrorError("Failed to get errors");
    }
  }
}
