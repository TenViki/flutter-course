import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isSecondary = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary
            ? Colors.grey.withOpacity(0.3)
            : Colors.deepOrange.withOpacity(0.3),
        foregroundColor: isSecondary ? Colors.white : Colors.deepOrange[100],
      ),
    );
  }
}
