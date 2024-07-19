import 'package:flutter/material.dart';
import 'package:netglade_onboarding/components/login_footer.dart';
import 'package:netglade_onboarding/components/login_form.dart';
import 'package:netglade_onboarding/components/login_page_template.dart';
import 'package:netglade_onboarding/util/page_transition.dart';
import 'package:netglade_onboarding/view/signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPageTemplate(
        topText: "Welcome back!",
        children: [
          const Expanded(
            child: LoginForm(),
          ),
          LoginFooter(
              onTap: () => Navigator.of(context)
                  .push(createTweenTransition(const SignupPage())),
              descText: "Don't have an account yet?",
              actionText: "Create it now!",
              icon: Icons.add)
        ],
      ),
    );
  }
}
