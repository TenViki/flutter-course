import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final bool isCompleted;
  final String name;
  const HabitTile({
    super.key,
    required this.isCompleted,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: isCompleted
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                ),
              ),
            ),
            if (isCompleted)
              Icon(
                Icons.check,
                color: Colors.white,
              ),
          ],
        ));
  }
}
