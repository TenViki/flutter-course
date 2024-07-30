import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/nav_drawer.dart';
import 'package:netglade_onboarding/models/telemetry.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:netglade_onboarding/services/telemetry_service.dart';
import 'package:netglade_onboarding/util/date_time.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsPage extends ConsumerWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final telemetryState = ref.watch(telemetryServiceProvider);
    final telemetryService = ref.read(telemetryServiceProvider.notifier);

    final List<Telemetry> lastTwenty = telemetryState is TelemetryData
        ? telemetryState.telemetry.length > 20
            ? telemetryState.telemetry.sublist(
                telemetryState.telemetry.length - 20,
                telemetryState.telemetry.length)
            : telemetryState.telemetry
        : [];

    if (authState is! AuthAuthenticated) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Charts"),
      ),
      drawer: const NavDrawer(),
      body: ListView(
        children: [
          if (telemetryService.minAltitude != null ||
              telemetryService.maxAltitude != null)
            const Text("Some filters are applied"),
          SfCartesianChart(
            title: const ChartTitle(text: "Temperature"),
            primaryXAxis: const CategoryAxis(),
            enableAxisAnimation: false,
            series: [
              SplineSeries<Telemetry, String>(
                dataSource: lastTwenty,
                xValueMapper: (data, _) => getTime(data.timestamp),
                yValueMapper: (data, _) => data.temperature,
                color: Colors.blue,
                animationDuration: 0,
              )
            ],
          ),
          SfCartesianChart(
            title: const ChartTitle(text: "Radiation"),
            primaryXAxis: const CategoryAxis(),
            enableAxisAnimation: false,
            series: [
              SplineSeries<Telemetry, String>(
                dataSource: lastTwenty,
                xValueMapper: (data, _) => getTime(data.timestamp),
                yValueMapper: (data, _) => data.radiation,
                color: Colors.red,
                animationDuration: 0,
              )
            ],
          ),
          SfCartesianChart(
            title: const ChartTitle(text: "Altitude"),
            primaryXAxis: const CategoryAxis(),
            enableAxisAnimation: false,
            series: [
              SplineSeries<Telemetry, String>(
                dataSource: lastTwenty,
                xValueMapper: (data, _) => getTime(data.timestamp),
                yValueMapper: (data, _) => data.altitude / 1000 / 1000,
                animationDuration: 0,
              )
            ],
          ),
          SfCartesianChart(
            title: const ChartTitle(text: "Velocity"),
            primaryXAxis: const CategoryAxis(),
            enableAxisAnimation: false,
            series: [
              SplineSeries<Telemetry, String>(
                dataSource: lastTwenty,
                xValueMapper: (data, _) => getTime(data.timestamp),
                yValueMapper: (data, _) => data.velocity,
                animationDuration: 0,
                color: Colors.green,
              )
            ],
          )
        ],
      ),
    );
  }
}
