import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onTap;
  final double padding;
  final Widget child;

  const Button({
    super.key,
    required this.onTap,
    required this.child,
    this.padding = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(padding),
          child: child,
        ),
      ),
    );
  }
}
