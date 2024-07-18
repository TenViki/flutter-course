import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netglade_onboarding/auth_bloc.dart';
import 'package:netglade_onboarding/auth_event.dart';
import 'package:netglade_onboarding/components/login_button.dart';
import 'package:netglade_onboarding/components/login_textfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    context.read<AuthBloc>().add(LoggedIn(
          username: _usernameController.text,
          password: _passwordController.text,
        ));
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
