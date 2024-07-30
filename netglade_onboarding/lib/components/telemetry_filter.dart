import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/services/telemetry_service.dart';
import 'package:netglade_onboarding/util/date_time.dart';

class TelemetryFilter extends ConsumerStatefulWidget {
  const TelemetryFilter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TelemetryFilterState();
}

class _TelemetryFilterState extends ConsumerState<TelemetryFilter> {
  final minAltitudeController = TextEditingController();
  final maxAltitudeController = TextEditingController();

  @override
  void initState() {
    minAltitudeController.text =
        ref.read(telemetryServiceProvider.notifier).minAltitude?.toString() ??
            "";
    ;
    maxAltitudeController.text =
        ref.read(telemetryServiceProvider.notifier).maxAltitude?.toString() ??
            "";
    super.initState();
  }

  @override
  void dispose() {
    minAltitudeController.dispose();
    maxAltitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final telemetryService = ref.watch(telemetryServiceProvider.notifier);

    return AlertDialog(
      title: const Text("Telemetry filters"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
                        lastDate: DateTime.now());

                    setState(() {
                      telemetryService.setStartDate(
                        // date with time set to 00:00:00
                        DateTime(date!.year, date.month, date.day),
                      );

                      telemetryService.setEndDate(
                        // date with time set to 23:59:59
                        DateTime(date.year, date.month, date.day, 23, 59, 59),
                      );
                    });
                  },
                  child: Text(
                    telemetryService.startDate == null
                        ? "Select date"
                        : formatDateTime(telemetryService.startDate!),
                  ),
                ),
              ),
              if (telemetryService.startDate != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      telemetryService.setStartDate(null);
                      telemetryService.setEndDate(null);
                    });
                  },
                ),
              ]
            ],
          ),
          SizedBox(height: 8),
          TextField(
            controller: minAltitudeController,
            decoration: const InputDecoration(
              labelText: "Min Altitude",
              hintText: "in meters",
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: maxAltitudeController,
            decoration: const InputDecoration(
              labelText: "Max Altitude",
              hintText: "in meters",
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              telemetryService.minAltitude =
                  int.tryParse(minAltitudeController.text);
              telemetryService.maxAltitude =
                  int.tryParse(maxAltitudeController.text);
              telemetryService.updateTelemetry();
              Navigator.of(context).pop();
            },
            child: const Text("Apply filters"),
          ),
        ],
      ),
    );
  }
}
