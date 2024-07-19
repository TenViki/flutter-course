import 'package:flutter/material.dart';

class NavDrawerLink extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const NavDrawerLink({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }
}
