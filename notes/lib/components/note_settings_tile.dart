import 'package:flutter/material.dart';

class NoteSettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;
  const NoteSettingsTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }
}
