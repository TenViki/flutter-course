import 'package:flutter/material.dart';

class FullscreenView extends StatelessWidget {
  final Widget child;
  const FullscreenView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        ),
      ],
    );
  }
}
