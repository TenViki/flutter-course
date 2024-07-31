import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/nav_drawer.dart';
import 'package:netglade_onboarding/components/telemetry_details.dart';
import 'package:netglade_onboarding/components/telemetry_filter.dart';
import 'package:netglade_onboarding/components/telemetry_tile.dart';
import 'package:netglade_onboarding/models/telemetry.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:netglade_onboarding/services/telemetry_service.dart';
import "package:sliding_up_panel/sliding_up_panel.dart";

final PanelController _pc = PanelController();

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Telemetry? selectedTelemetry;
  List<Telemetry> telemetry = [];

  void openTelemetryDetails(Telemetry telemetry) {
    // statefully change the selected telemetry
    setState(() {
      selectedTelemetry = telemetry;
    });

    _pc.open();
  }

  void openTelemetryFilter() {
    showDialog(
      context: context,
      builder: (context) => const TelemetryFilter(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authServiceProvider);
    final telemetryState = ref.watch(telemetryServiceProvider);

    if (authState is! AuthAuthenticated) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(telemetryServiceProvider.notifier).updateTelemetry();
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: openTelemetryFilter,
          ),
        ],
      ),
      drawer: const NavDrawer(),
      body: SlidingUpPanel(
          minHeight: 0,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          controller: _pc,
          isDraggable: true,
          backdropEnabled: true,
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          panel: TelemetryDetails(telemetry: selectedTelemetry),
          body: switch (telemetryState) {
            TelemetryData(telemetry: var telemetry) => ListView.builder(
                itemBuilder: (context, index) {
                  if (index == telemetry.length) {
                    return SizedBox(height: 120);
                  }

                  final data = telemetry[telemetry.length - index - 1];

                  return TelemetryTile(
                    telemetry: data,
                    onTap: () => openTelemetryDetails(data),
                  );
                },
                itemCount: telemetry.length + 1,
              ),
            TelemetryError(message: var message) => Center(
                child: Text(message),
              ),
            TelemetryLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
          }),
    );
  }
}
