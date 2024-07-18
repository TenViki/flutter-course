import 'package:flutter/material.dart';

class LoginOptionButton extends StatelessWidget {
  final void Function()? onTap;
  final String imageUrl;
  const LoginOptionButton(
      {super.key, required this.onTap, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(9),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Image.asset(
              imageUrl,
              height: 48,
            ),
          ),
        ),
      ),
    );
  }
}
