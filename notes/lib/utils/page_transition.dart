import 'package:flutter/material.dart';

Route createRoute(Widget Page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var curve = Curves.ease;
      var curveTween = CurveTween(curve: curve);

      const begin = Offset(0.0, 0.5);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end).chain(curveTween);

      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: animation.drive(tween),
          child: child,
        ),
      );
    },
  );
}
