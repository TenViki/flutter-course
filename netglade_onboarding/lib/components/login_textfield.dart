import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final IconData icon;
  final TextInputAction textInputAction;

  final String? Function(String?)? validator;

  const LoginTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.validator,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        contentPadding: const EdgeInsets.all(16),
        fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
