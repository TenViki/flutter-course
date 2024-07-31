import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/models/telemetry_error.dart';
import 'package:netglade_onboarding/util/date_time.dart';

class ErrorTile extends ConsumerWidget {
  final TelemetryError error;
  const ErrorTile({super.key, required this.error});

  String decodeErrorData(String code) {
    return utf8.decode(base64.decode(code));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTile(
      title: Text(getDateTime(error.timestamp)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Error data:",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Text(
                  error.errorData,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: "monospace",
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Error message:",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                decodeErrorData(error.errorData),
                style: const TextStyle(
                  fontFamily: "monospace",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
