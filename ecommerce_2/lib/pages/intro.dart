import 'package:ecommerce_2/components/button.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.shopping_bag,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            SizedBox(height: 32),

            // title
            Text(
              "Store Minimal",
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            // subtitle
            Text(
              "Premium quality things",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            const SizedBox(height: 32),

            // button
            Button(
              onTap: () => Navigator.pushNamed(context, "/shop"),
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
