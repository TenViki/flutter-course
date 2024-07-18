import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterauthtest/components/login_button.dart';
import 'package:flutterauthtest/components/login_option_button.dart';
import 'package:flutterauthtest/components/login_textfield.dart';
import 'package:flutterauthtest/components/single_page_scroll_view.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Colors.red,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signInUsername() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )));

    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "user-not-found":
        case "invalid-email":
          showErrorMessage("User not found");
          break;
        case "invalid-credential":
          showErrorMessage("Wrong password");
          break;
        case "channel-error":
          showErrorMessage("Please fill in the fields");
          break;
        default:
          showErrorMessage("An error occurred: ${error.code}");
      }
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      body: SinglePageScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                Icon(
                  Icons.lock,
                  size: 120,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(height: 50),
                Text(
                  "Welcome back!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                ),
                const SizedBox(height: 24),

                // email password
                LoginTextField(
                  hintText: "E-mail",
                  controller: emailController,
                  icon: Icons.perm_identity,
                ),
                const SizedBox(height: 8),
                LoginTextField(
                  hintText: "Password",
                  icon: Icons.lock_outline,
                  controller: passwordController,
                  obscure: true,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            // decoration: TextDecoration.underline,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                LoginButton(onTap: signInUsername),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24 + 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ),
                      const Expanded(child: Divider())
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginOptionButton(
                      onTap: () {},
                      imageUrl: "assets/google.png",
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    LoginOptionButton(
                      onTap: () {},
                      imageUrl: "assets/apple.png",
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Sign up now!",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
