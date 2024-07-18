import 'package:flutter/material.dart';
import 'package:netglade_onboarding/components/login_footer.dart';
import 'package:netglade_onboarding/components/login_page_template.dart';
import 'package:netglade_onboarding/components/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginPageTemplate(
      topText: "Create an account",
      children: [
        const Expanded(
          child: SignupForm(),
        ),
        LoginFooter(
            onTap: () => Navigator.of(context).pop(),
            descText: "Already have an account?",
            actionText: "Log in instead!",
            icon: Icons.chevron_left)
      ],
    ));
  }
}
