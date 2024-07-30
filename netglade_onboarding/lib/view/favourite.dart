import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/nav_drawer.dart';
import 'package:netglade_onboarding/components/telemetry_tile.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:netglade_onboarding/services/telemetry_service.dart';

class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final telemetryState = ref.watch(telemetryServiceProvider);

    if (authState is! AuthAuthenticated) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      drawer: const NavDrawer(),
      body: telemetryState is TelemetryData
          ? ListView.builder(
              itemBuilder: (context, index) {
                final data = telemetryState.favouriteTelemetries[
                    telemetryState.favouriteTelemetries.length - index - 1];

                return TelemetryTile(
                  telemetry: data,
                  onTap: () {},
                );
              },
              itemCount: telemetryState.favouriteTelemetries.length,
            )
          : telemetryState is TelemetryError
              ? Center(
                  child: Text(telemetryState.message),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}