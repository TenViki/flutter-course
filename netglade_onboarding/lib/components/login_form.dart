import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/components/login_button.dart';
import 'package:netglade_onboarding/components/login_textfield.dart';
import 'package:netglade_onboarding/providers.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void handleLogin() {
    ref.watch(authBlocProvider.notifier).authenticate(
          _usernameController.text,
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoginTextfield(
            controller: _usernameController,
            hintText: "Username",
            icon: Icons.person,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          LoginTextfield(
            controller: _passwordController,
            hintText: "Password",
            icon: Icons.lock,
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 16),
          LoginButton(
            text: "Login",
            onTap: handleLogin,
          )
        ],
      ),
    );
  }
}
