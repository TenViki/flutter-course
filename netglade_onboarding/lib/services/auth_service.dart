import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import 'package:netglade_onboarding/repos/auth_repository.dart';

import '../auth_state.dart';

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final _storage = const FlutterSecureStorage();

  AuthService(this._authRepository) : super(AuthInitial()) {
    _intialAuth();
  }

  Future<void> authenticate(String username, String password) async {
    state = AuthLoading();
    try {
      print("Trying to auth");
      final result = await _authRepository.authenticate(username, password);
      final token = result['token']!;
      final user = await _authRepository.getUser(token);
      print("Auth success");

      await _storage.write(key: "auth_token", value: token);
      print(result);
      await _storage.write(
          key: "auth_token_expire", value: result['expiration']!);
      state = AuthAuthenticated(token, user);
    } catch (e) {
      print("ERROR: $e");
      state = const AuthFailure('Authentication failed');
    }
  }

  Future<void> logout() async {
    if (state is AuthAuthenticated) {
      final token = (state as AuthAuthenticated).token;

      await _storage.delete(key: "auth_token");
      await _storage.delete(key: "auth_token_expire");

      try {
        await _authRepository.logout(token);
        state = AuthUnauthenticated();
      } catch (e) {
        state = const AuthFailure('Logout failed');
      }
    }
  }

  Future<void> _intialAuth() async {
    try {
      final token = await _storage.read(key: "auth_token");
      final tokenExpire = await _storage.read(key: "auth_token_expire");

      // check if token is expired
      if (tokenExpire != null) {
        final expire = DateTime.parse(tokenExpire);
        if (expire.isBefore(DateTime.now())) {
          await _storage.delete(key: "auth_token");
          await _storage.delete(key: "auth_token_expire");
          state = AuthUnauthenticated();
          return;
        }
      } else {
        await _storage.delete(key: "auth_token");
        await _storage.delete(key: "auth_token_expire");
        state = AuthUnauthenticated();
        return;
      }

      print("APP STARTUP");
      print(token);
      print(tokenExpire);

      if (token != null) {
        final user = await _authRepository.getUser(token);
        state = AuthAuthenticated(token, user);
      } else {
        state = AuthUnauthenticated();
      }
    } catch (e) {
      state = const AuthFailure('Failed to authenticate');
    }
  }
}
