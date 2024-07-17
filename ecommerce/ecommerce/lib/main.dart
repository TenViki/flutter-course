import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/pages/home.dart';
import 'package:ecommerce/pages/intro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const IntroPage(),
        routes: {
          "/intro": (context) => const IntroPage(),
          "/home": (context) => const HomePage(),
        },
      ),
    );
  }
}
