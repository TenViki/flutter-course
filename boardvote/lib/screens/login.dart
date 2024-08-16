import 'package:boardvote/components/fullscreen_view.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullscreenView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Image.asset(
                    'assets/logo.png',
                    color: Theme.of(context).colorScheme.primary,
                    width: 100,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to BoardVote',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  RawMaterialButton(
                    onPressed: () => throw Exception(),
                    padding: const EdgeInsets.only(
                      left: 12,
                      bottom: 12,
                      top: 12,
                      right: 24,
                    ),
                    fillColor: Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          width: 24,
                        ),
                        const SizedBox(width: 8),
                        Text('Continue with Google'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
