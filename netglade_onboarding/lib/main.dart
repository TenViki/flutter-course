import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:netglade_onboarding/auth_builder.dart";
import "package:netglade_onboarding/theme/themes.dart";

void main() {
  // write here ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthBuilder(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
