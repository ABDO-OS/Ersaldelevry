import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodly_ui/screens/auth/sign_in_screen.dart';

import '../../components/buttons/socal_button.dart';
import '../../components/welcome_text.dart';
import '../../constants.dart';
import '../signUp/components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء حساب")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeText(
                title: "إنشاء حساب",
                text:
                    "أدخل اسمك والبريد الإلكتروني وكلمة المرور \nلإنشاء حساب.",
              ),

              // Sign Up Form
              const SignUpForm(),
              const SizedBox(height: defaultPadding),

              // Already have account
              Center(
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    text: "Already have account? ",
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sign In",
                        style: const TextStyle(color: primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Center(
                child: Text(
                  "By Signing up you agree to our Terms \nConditions & Privacy Policy.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: defaultPadding),
              kOrText,
              const SizedBox(height: defaultPadding),

              // Facebook
              SocalButton(
                press: () {},
                text: "التواصل مع فيسبوك",
                color: const Color(0xFF395998),
                icon: const Icon(Icons.facebook, color: Colors.white),
              ),
              const SizedBox(height: defaultPadding),

              // Google
              SocalButton(
                press: () {},
                text: "التواصل مع جوجل",
                color: const Color(0xFF4285F4),
                icon: const Icon(Icons.g_mobiledata, color: Colors.white),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
