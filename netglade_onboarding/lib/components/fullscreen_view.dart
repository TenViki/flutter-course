import 'package:flutter/material.dart';

class FullscreenView extends StatelessWidget {
  final Widget child;
  const FullscreenView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(
          child: SafeArea(
            child: child,
          ),
        ),
      ),
    );
  }
}
