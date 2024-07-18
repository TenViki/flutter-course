import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      // Simulate a delay for loading initial state
      await Future.delayed(Duration(seconds: 1));
      emit(AuthUnauthenticated());
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      // Simulate a delay for authentication
      await Future.delayed(Duration(seconds: 1));
      // Simple auth logic: username == password
      if (event.username == event.password) {
        // Generate a mock token for the example
        final token = 'mock_token_${event.username}';

        emit(AuthAuthenticated(
            event.username, "${event.username}@test.cz", token));
      } else {
        emit(AuthFailure("Incorrect username or password"));
      }
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthUnauthenticated());
    });
  }
}
