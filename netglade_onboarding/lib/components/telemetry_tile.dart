import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/models/telemetry.dart';
import 'package:netglade_onboarding/services/telemetry_service.dart';
import 'package:netglade_onboarding/util/date_time.dart';
import 'package:netglade_onboarding/util/telemetry.dart';

class TelemetryTile extends ConsumerWidget {
  final Telemetry telemetry;
  final VoidCallback onTap;
  const TelemetryTile(
      {super.key, required this.telemetry, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telemetryState = ref.watch(telemetryServiceProvider);
    final telemetryService = ref.read(telemetryServiceProvider.notifier);

    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          Text(getTime(telemetry.timestamp)),
          const SizedBox(width: 8),
          Text(
            getDate(telemetry.timestamp),
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      subtitle: Row(
        children: [
          // guessing that these are in millimeters
          Text("${(telemetry.altitude / 1000 / 1000).floor()}km"),
          const SizedBox(width: 8),
          Text("${telemetry.temperature}K"),
          const SizedBox(width: 8),
          Text("${telemetry.velocity}m/s"),
          const SizedBox(width: 8),
          Text("${telemetry.radiation}cps"),
        ],
      ),
      trailing: telemetryState is TelemetryData
          ? IconButton(
              onPressed: () =>
                  telemetryService.toggleFavourite(telemetry, context),
              icon: isFavorite(telemetry, telemetryState.favouriteTelemetries)
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border))
          : const CircularProgressIndicator(),
    );
  }
}
