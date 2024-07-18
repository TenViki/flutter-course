
import 'package:flutter/material.dart';

import 'package:netglade_onboarding_flutter/telemetry_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, required this.authToken, super.key});

  final String title;
  final String? authToken;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic input;
  String? fetchError;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(widget.title),
      ),
      body: Center(
        child: fetchError == null
            ? TelemetryWidget(
                authToken: widget.authToken,
              )
            : const Text('An internal error has occured.'),
      ),
    );
  }
}
