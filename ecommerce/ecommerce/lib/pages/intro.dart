import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
              child: Image.asset(
                "lib/img/logo.png",
                height: 200,
              ),
            ),

            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Samsung shop",
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Welcome to the Samsung shop. We have the best products for you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // start shopping button
            const SizedBox(height: 200),
            Container(
              child: Material(
                color: const Color.fromRGBO(11, 32, 137, 1),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    // decoration: BoxDecoration(
                    //   color: Colors.blue,
                    //   borderRadius: BorderRadius.circular(5),
                    // ),
                    child: const Text(
                      "Start shopping",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
