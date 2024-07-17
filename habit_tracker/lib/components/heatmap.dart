import 'package:flutter/material.dart';
import "package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart";

class HabitHeatMap extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, int> dataset;
  const HabitHeatMap(
      {super.key, required this.startDate, required this.dataset});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      colorsets: {
        1: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        2: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        3: Colors.red,
        4: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        5: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      },
      startDate: startDate,
      datasets: dataset,
      scrollable: true,
      showText: true,
      showColorTip: false,
      defaultColor: Theme.of(context).colorScheme.surfaceContainerLow,
    );
  }
}
