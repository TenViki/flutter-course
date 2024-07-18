import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:netglade_onboarding/auth_bloc.dart";
import "package:netglade_onboarding/auth_builder.dart";
import "package:netglade_onboarding/auth_event.dart";
import "package:netglade_onboarding/theme/themes.dart";

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(AppStarted()),
      child: MainApp(),
    ),
  );
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
