import 'package:flutter/material.dart';

const _mainColor = Colors.red;

final lightTheme = ThemeData(
  colorScheme:
      ColorScheme.fromSeed(seedColor: _mainColor, brightness: Brightness.light),
);

final darkTheme = ThemeData(
  colorScheme:
      ColorScheme.fromSeed(seedColor: _mainColor, brightness: Brightness.dark),
);
