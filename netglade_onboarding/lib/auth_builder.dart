import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:netglade_onboarding/view/home.dart';
import 'package:netglade_onboarding/view/login.dart';
import 'package:netglade_onboarding/view/splash.dart';

class AuthBuilder extends ConsumerWidget {
  const AuthBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final authService = ref.watch(authServiceProvider.notifier);

    ref.listen(authServiceProvider, (prevState, _) {
      if (prevState is AuthLoading) {
        Navigator.pop(context);
      }
    });

    if (authState is AuthInitial) {
      return const SplashScreen();
    }

    if (authState is AuthUnauthenticated ||
        authState is AuthFailure ||
        authState is AuthLoading) {
      return const LoginPage();
    }

    if (authState is AuthAuthenticated) {
      // Navigator.pop(context);
      // Navigator.of(context).pop();
      return const HomePage();
    }

    return Container();

    // return BlocBuilder<authService, AuthState>(builder: (context, state) {
    //   if (state is AuthInitial)
    //     return SplashScreen();
    //   else if (state is AuthUnauthenticated ||
    //       state is AuthFailure ||
    //       state is AuthLoading) {
    //     return LoginPage();
    //   } else if (state is AuthAuthenticated) {
    //     Navigator.pop(context);
    //     return HomePage();
    //   }
    //   return Container();
    // });
  }
}
