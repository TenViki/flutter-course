import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? onDelete;

  const TodoTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.3,
          children: [
            // SizedBox(width: 12),
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Colors.red.withOpacity(0.3),
              foregroundColor: Colors.red,
              borderRadius: BorderRadius.circular(6),
              icon: Icons.delete,
            ),
          ],
        ),
        child: Material(
          color: Colors.deepOrange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => onChanged!(!taskCompleted),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.deepOrange,
                  ),
                  AnimatedLineThrough(
                    isCrossed: taskCompleted,
                    duration: const Duration(milliseconds: 150),
                    child: Text(taskName),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
