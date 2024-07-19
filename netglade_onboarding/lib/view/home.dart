import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/nav_drawer.dart';
import 'package:netglade_onboarding/components/telemetry_details.dart';
import 'package:netglade_onboarding/components/telemetry_tile.dart';
import 'package:netglade_onboarding/models/telemetry.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:netglade_onboarding/services/telemetry_service.dart';
import "package:sliding_up_panel/sliding_up_panel.dart";

final PanelController _pc = PanelController();

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Telemetry? selectedTelemetry = null;

  void openTelemetryDetails(Telemetry telemetry) {
    // statefully change the selected telemetry
    setState(() {
      selectedTelemetry = telemetry;
    });

    _pc.open();
  }

  @override
  void initState() {
    // _pc.hide();
    super.initState();
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
      ),
      drawer: NavDrawer(),
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
        body: telemetryState is TelemetryData
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final data = telemetryState
                      .telemetry[telemetryState.telemetry.length - index - 1];

                  return TelemetryTile(
                    telemetry: data,
                    onTap: () => openTelemetryDetails(data),
                  );
                },
                itemCount: telemetryState.telemetry.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
