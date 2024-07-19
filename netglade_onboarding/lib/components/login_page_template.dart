import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/fullscreen_view.dart';
import 'package:netglade_onboarding/providers.dart';

class LoginPageTemplate extends ConsumerStatefulWidget {
  final List<Widget> children;
  final String topText;
  const LoginPageTemplate({
    super.key,
    required this.children,
    required this.topText,
  });

  @override
  ConsumerState<LoginPageTemplate> createState() => _LoginPageTemplateState();
}

class _LoginPageTemplateState extends ConsumerState<LoginPageTemplate> {
  void handleAuthStateChange(AuthState state) {
    // if auth failure, show snackbar
    if (state is AuthFailure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          state.error,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ));
    }

    // if authloading, show loading dialog
    if (state is AuthLoading) {
      showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(
        authServiceProvider, (_, state) => handleAuthStateChange(state));

    return FullscreenView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          const SizedBox(height: 24),
          Image.asset("assets/logo.png", height: 200),
          const SizedBox(height: 32),
          Text(
            widget.topText,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 24),
          ...widget.children,
        ]),
      ),
    );
  }
}
