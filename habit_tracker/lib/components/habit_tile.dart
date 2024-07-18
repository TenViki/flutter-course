import 'package:flutter/material.dart';
import "package:flutter_slidable/flutter_slidable.dart";
import 'package:habit_tracker/models/habit.dart';

class HabitTile extends StatelessWidget {
  final bool isCompleted;
  final String name;
  final void Function(bool?) onChanged;
  final void Function() onEdit;
  final void Function() onDelete;
  const HabitTile({
    super.key,
    required this.isCompleted,
    required this.name,
    required this.onChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onEdit(),
              icon: Icons.edit,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            SlidableAction(
              onPressed: (_) => onDelete(),
              icon: Icons.delete,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.surfaceContainerHigh,
          child: InkWell(
            onTap: () => onChanged(!isCompleted),
            borderRadius: BorderRadius.circular(8),
            child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Checkbox(value: isCompleted, onChanged: onChanged),
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
                      const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
