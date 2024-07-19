import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authBlocProvider);
    final authBloc = ref.watch(authBlocProvider.notifier);

    if (authState is! AuthAuthenticated) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to the Home Page"),
            Text("Logged in: ${authState.user.email}"),
            ElevatedButton(
              onPressed: () {
                authBloc.logout();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      )),
    );
  }
}
