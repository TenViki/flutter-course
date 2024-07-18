import 'package:flutter/material.dart';
import 'package:netglade_onboarding/components/login_button.dart';
import 'package:netglade_onboarding/components/login_textfield.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void handleLogin() {
    print("Logging in...");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoginTextfield(
            controller: usernameController,
            hintText: "Username",
            icon: Icons.person,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          LoginTextfield(
            controller: usernameController,
            hintText: "E-mail",
            icon: Icons.email,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          LoginTextfield(
            controller: passwordController,
            hintText: "Password",
            icon: Icons.lock,
            obscureText: true,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 16),
          LoginButton(
            text: "Sign up",
            onTap: handleLogin,
          )
        ],
      ),
    );
  }
}
