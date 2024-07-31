import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:netglade_onboarding/auth_builder.dart";
import "package:netglade_onboarding/theme/themes.dart";
import 'package:netglade_onboarding/view/charts.dart';
import 'package:netglade_onboarding/view/errors.dart';
import 'package:netglade_onboarding/view/favourite.dart';
import 'package:netglade_onboarding/view/home.dart';
import 'package:netglade_onboarding/view/profile.dart';

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
      routes: {
        "/home": (context) => const HomePage(),
        "/favourites": (context) => const FavouritePage(),
        "/charts": (context) => const ChartsPage(),
        "/profile": (context) => const ProfilePage(),
        "/errors": (context) => const ErrorsPage(),
      },
    );
  }
}
