import 'package:equatable/equatable.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/models/telemetry_error.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "errors_service.g.dart";

class TelemetryErrorState extends Equatable {
  const TelemetryErrorState();

  @override
  List<Object> get props => [];
}

class TelemetryErrorLoading extends TelemetryErrorState {}

class TelemetryErrorData extends TelemetryErrorState {
  final List<TelemetryError> errors;

  const TelemetryErrorData(this.errors);

  @override
  List<Object> get props => [errors];
}

class TelemetryErrorError extends TelemetryErrorState {
  final String message;

  const TelemetryErrorError(this.message);

  @override
  List<Object> get props => [message];
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
      state = const TelemetryErrorError("Failed to get errors");
    }
  }
}
