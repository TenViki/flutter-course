import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/models/telemetry.dart';
import 'package:netglade_onboarding/services/telemetry_service.dart';
import 'package:netglade_onboarding/util/date_time.dart';
import 'package:netglade_onboarding/util/telemetry.dart';

class TelemetryDetails extends ConsumerWidget {
  final Telemetry? telemetry;
  const TelemetryDetails({super.key, required this.telemetry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telemetryState = ref.watch(telemetryServiceProvider);
    final telemetryService = ref.read(telemetryServiceProvider.notifier);

    if (telemetry == null || telemetryState is! TelemetryData) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 120,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(.3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Telemetry Details",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildDetail(context, "Time captured",
                  getDateTime(telemetry!.timestamp), Icons.access_time),
              _buildDetail(context, "Velocity", "${telemetry!.velocity} m/s",
                  Icons.speed),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildDetail(
                context,
                "Altitude",
                "${(telemetry!.altitude / 1000 / 1000).floor()} km",
                Icons.height,
              ),
              _buildDetail(context, "Temperature",
                  "${telemetry!.temperature} K", Icons.thermostat),
            ],
          ),
          const SizedBox(height: 24),
          Row(children: [
            _buildDetail(context, "Radiation", "${telemetry!.radiation} cps",
                Icons.cell_tower)
          ]),
          Expanded(child: Container()),
          RawMaterialButton(
            onPressed: () =>
                telemetryService.toggleFavourite(telemetry!, context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            fillColor: telemetry != null &&
                    isFavorite(telemetry!, telemetryState.favouriteTelemetries)
                ? Theme.of(context).colorScheme.secondary.withOpacity(.1)
                : Theme.of(context).colorScheme.secondaryContainer,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: telemetry != null &&
                      isFavorite(
                          telemetry!, telemetryState.favouriteTelemetries)
                  ? Text("Remove from favorites",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ))
                  : Text("Add to favorites",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  _buildDetail(
      BuildContext context, String title, String value, IconData icon) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
