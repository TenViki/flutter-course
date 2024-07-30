import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netglade_onboarding/components/login_button.dart';
import 'package:netglade_onboarding/components/login_textfield.dart';
import 'package:netglade_onboarding/providers.dart';
import 'package:netglade_onboarding/util/validators.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void handleSignup() async {
    if (!_signupFormKey.currentState!.validate()) return;

    await ref.watch(authServiceProvider.notifier).register(
          _usernameController.text,
          _emailController.text,
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoginTextfield(
            controller: _usernameController,
            hintText: "Username",
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a username";
              }
              return null;
            },
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          LoginTextfield(
            controller: _emailController,
            hintText: "E-mail",
            icon: Icons.email,
            validator: emailValidator,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          LoginTextfield(
            controller: _passwordController,
            hintText: "Password",
            icon: Icons.lock,
            obscureText: true,
            validator: passwordValidator,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 16),
          LoginButton(
            text: "Sign up",
            onTap: handleSignup,
          )
        ],
      ),
    );
  }
}
