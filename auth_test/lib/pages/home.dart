import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void logout() async {
    await FirebaseAuth.instance.signOut();

    print("Logged out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome ${user.email}!"),
            ElevatedButton(
              onPressed: logout,
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
