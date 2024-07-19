import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/nav_drawer_link.dart';
import 'package:netglade_onboarding/providers.dart';

class NavDrawer extends ConsumerWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider) as AuthAuthenticated;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.satellite_alt,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          NavDrawerLink(
            text: "Home",
            icon: Icons.home,
            onTap: () {},
          ),
          NavDrawerLink(
            text: "Charts",
            icon: Icons.line_axis,
            onTap: () {},
          ),
          NavDrawerLink(
            text: "Favorites",
            icon: Icons.star,
            onTap: () {},
          ),
          NavDrawerLink(
            text: "Errors",
            icon: Icons.error,
            onTap: () {},
          ),
          const Expanded(child: SizedBox()),
          NavDrawerLink(
            text: authState.user.username,
            icon: Icons.person,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
