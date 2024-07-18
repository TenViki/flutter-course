import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netglade_onboarding/auth_bloc.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/view/login.dart';
import 'package:netglade_onboarding/view/splash.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthInitial)
        return SplashScreen();
      else if (state is AuthUnauthenticated ||
          state is AuthFailure ||
          state is AuthLoading) {
        return LoginPage();
      } else if (state is AuthAuthenticated) {
        return Text("Authenticated as ${state.email}");
      }
      return Container();
    });
  }
}
