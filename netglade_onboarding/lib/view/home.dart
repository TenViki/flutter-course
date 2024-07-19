import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/nav_drawer.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:netglade_onboarding/services/telemetry_service.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final authService = ref.watch(authServiceProvider.notifier);
    final telemetryState = ref.watch(telemetryServiceProvider);

    // print("Telemetry State: $telemetryState");

    if (authState is! AuthAuthenticated) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: NavDrawer(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome to the Home Page"),
              Text("Logged in: ${authState.user.email}"),
              ElevatedButton(
                onPressed: () {
                  authService.logout();
                },
                child: const Text("Logout"),
              ),
              Text("Telemetry State: $telemetryState"),
            ],
          ),
        ),
      ),
    );
  }
}
