import 'package:flutter/material.dart';
import 'package:notes/components/drawer_tile.dart';
import 'package:notes/pages/settings.dart';
import 'package:notes/utils/page_transition.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
              child: Icon(
            Icons.edit,
            size: 72,
          )),
          const SizedBox(height: 16),
          DrawerTile(
            icon: Icons.home,
            title: "My notes",
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                createRoute(const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
