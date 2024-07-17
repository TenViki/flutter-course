import 'package:flutter/material.dart';
import 'package:notes/components/note_settings.dart';
import "package:popover/popover.dart";

class NoteTile extends StatelessWidget {
  final String text;
  final Function() onDelete;
  final Function() onEdit;
  const NoteTile(
      {super.key,
      required this.text,
      required this.onDelete,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      padding: const EdgeInsets.all(16),
      child: ListTile(
        title: Text(text),
        contentPadding: EdgeInsets.only(left: 16),
        trailing: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => showPopover(
              context: context,
              backgroundColor: Theme.of(context).colorScheme.surface,
              bodyBuilder: (context) => NoteSettings(
                onEdit: onEdit,
                onDelete: onDelete,
              ),
              width: 200,
              // height: 150,
            ),
          );
        }),
      ),
    );
  }
}
