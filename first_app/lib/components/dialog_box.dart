import 'package:flutter/material.dart';
import 'package:todo_app/components/button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add a new task"),
      content: Container(
        // fit the content height
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter task name",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  onPressed: onCancel,
                  text: "Cancel",
                  isSecondary: true,
                ),
                const SizedBox(
                  width: 8,
                ),
                Button(onPressed: onSave, text: "Add Task"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
