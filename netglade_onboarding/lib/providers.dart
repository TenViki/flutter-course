import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/repos/telemetry_repository.dart';

import 'repos/auth_repository.dart';
import 'services/auth_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://192.168.1.162:5104'));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthService(authRepository);
});

final telemetryRepositoryProvider =
    Provider((ref) => TelemetryRepository(ref.read(dioProvider)));
