import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';

import 'auth_bloc.dart';
import 'auth_repository.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://192.168.1.162:5104'));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

final authBlocProvider = StateNotifierProvider<AuthBloc, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthBloc(authRepository);
});
