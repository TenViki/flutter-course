import 'package:flutter/material.dart';
import 'package:notes/components/note_settings_tile.dart';

class NoteSettings extends StatelessWidget {
  final void Function() onEdit;
  final void Function() onDelete;
  const NoteSettings({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NoteSettingsTile(
          title: "Edit",
          onTap: () {
            Navigator.pop(context);
            onEdit();
          },
          icon: Icons.edit,
        ),
        NoteSettingsTile(
          title: "Delete",
          onTap: () {
            Navigator.pop(context);
            onDelete();
          },
          icon: Icons.delete,
        ),
      ],
    );
  }
}
