import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/error_tile.dart';
import 'package:netglade_onboarding/components/nav_drawer.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:netglade_onboarding/services/errors_service.dart';

class ErrorPage extends ConsumerStatefulWidget {
  const ErrorPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ErrorPageState();
}

class _ErrorPageState extends ConsumerState<ErrorPage> {
  @override
  void initState() {
    final authState = ref.read(authServiceProvider);
    final errorProvider = ref.read(telemetryErrorServiceProvider.notifier);

    if (authState is AuthAuthenticated) {
      errorProvider.updateErrors();
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider);
    final errorState = ref.watch(telemetryErrorServiceProvider);

    if (authState is! AuthAuthenticated) {
      return Container();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Errors"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(telemetryErrorServiceProvider.notifier).updateErrors();
              },
            ),
          ],
        ),
        drawer: const NavDrawer(),
        body:
            // switch
            switch (errorState) {
          TelemetryErrorLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          TelemetryErrorData(errors: var errors) => ListView.builder(
              itemBuilder: (context, index) {
                final data = errors[errors.length - index - 1];

                return ErrorTile(
                  error: data,
                );
              },
              itemCount: errors.length,
            ),
          TelemetryErrorError(message: var message) => Center(
              child: Text(message),
            ),
        });
  }
}
