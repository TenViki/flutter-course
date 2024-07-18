import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netglade_onboarding/auth_bloc.dart';
import 'package:netglade_onboarding/auth_state.dart';
import 'package:netglade_onboarding/components/fullscreen_view.dart';

class LoginPageTemplate extends StatefulWidget {
  final List<Widget> children;
  final String topText;
  const LoginPageTemplate({
    super.key,
    required this.children,
    required this.topText,
  });

  @override
  State<LoginPageTemplate> createState() => _LoginPageTemplateState();
}

class _LoginPageTemplateState extends State<LoginPageTemplate> {
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

      // also pop the loading dialog
      Navigator.pop(context);
    }

    // if authloading, show loading dialog
    if (state is AuthLoading) {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => handleAuthStateChange(state),
      child: FullscreenView(
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
      ),
    );
  }
}
