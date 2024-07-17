import 'package:ecommerce_2/models/shop.dart';
import 'package:ecommerce_2/pages/cart.dart';
import 'package:ecommerce_2/pages/intro.dart';
import 'package:ecommerce_2/pages/shop.dart';
import 'package:ecommerce_2/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      theme: lightMode,
      routes: {
        '/intro': (context) => const IntroPage(),
        '/shop': (context) => const ShopPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
