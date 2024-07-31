import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/fullscreen_view.dart';
import 'package:netglade_onboarding/components/nav_drawer.dart';
import 'package:netglade_onboarding/providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final authService = ref.read(authServiceProvider.notifier);

    if (authState is! AuthAuthenticated) {
      // go to login

      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      drawer: const NavDrawer(),
      body: FullscreenView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.person,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text("Username"),
              subtitle: Text(authState.user.username),
            ),
            ListTile(
              title: const Text("Email"),
              subtitle: Text(authState.user.email),
            ),
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/");
                authService.logout();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "Sign out",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
