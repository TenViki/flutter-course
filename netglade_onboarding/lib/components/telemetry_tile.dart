import 'package:flutter/material.dart';
import 'package:netglade_onboarding/models/telemetry.dart';
import 'package:netglade_onboarding/util/date_time.dart';

class TelemetryTile extends StatelessWidget {
  final Telemetry telemetry;
  final VoidCallback onTap;
  const TelemetryTile(
      {super.key, required this.telemetry, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
      subtitle: Row(
        children: [
          // guessing that these are in millimeters
          Text("${(telemetry.altitude / 1000 / 1000).floor()}km"),
          const SizedBox(width: 8),
          Text("${telemetry.temperature}°K"),
          const SizedBox(width: 8),
          Text("${telemetry.velocity}m/s"),
          const SizedBox(width: 8),
          Text("${telemetry.radiation}cps"),
        ],
      ),
      trailing: Icon(Icons.star_outline),
    );
  }
}
