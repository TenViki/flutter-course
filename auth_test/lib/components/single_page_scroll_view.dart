import 'package:flutter/material.dart';

class SinglePageScrollView extends StatelessWidget {
  final Widget child;
  const SinglePageScrollView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
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
