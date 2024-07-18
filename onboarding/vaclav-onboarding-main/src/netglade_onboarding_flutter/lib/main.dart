import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:netglade_onboarding_flutter/homescreen_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latest Satellite Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(title: 'Latest Satellite data'),
    );
  }
}

class Login extends StatefulWidget {
  const Login({required this.title, super.key});

  final String title;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? token;
  Future<void> loginPost(String username, String password) async {
    try {
      final data = <String, String>{
        'username': username,
        'password': password,
      };
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5104/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      setState(() {
        if (response.statusCode == 200) {
          final dynamic json = jsonDecode(response.body);
          // ignore: avoid_dynamic_calls
          token = json['token'] as String;
        } else {
          token = null;
        }
      });

      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginPost(
                          usernameController.text,
                          passwordController.text,
                        ).whenComplete(
                          () => {
                            if (token != null)
                              {
                                Navigator.push(
                                  context,
                                  // ignore: inference_failure_on_instance_creation
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                      title: 'Latest telemetry data',
                                      authToken: token.toString(),
                                    ),
                                  ),
                                )
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: Container(
                                      padding: const EdgeInsets.all(16),
                                      height: 90,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFC72C41),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: const Text(
                                        'Invalid credentials',
                                      ),
                                    ),
                                  ),
                                )
                              }
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill input')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
