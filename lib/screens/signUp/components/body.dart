import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../components/buttons/socal_button.dart';
import '../../../components/welcome_text.dart';
import '../../../constants.dart';
import '../../auth/sign_in_screen.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
              const SizedBox(height: 16),

              // Already have account
              Center(
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    text: "لديك حساب بالفعل؟ ",
                    children: <TextSpan>[
                      TextSpan(
                        text: "تسجيل الدخول",
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
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "بإنشاء حساب، فإنك توافق على شروطنا \nوأحكام وسياسة الخصوصية.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              kOrText,
              const SizedBox(height: 16),

              // Facebook
              SocalButton(
                press: () {},
                text: "التواصل مع فيسبوك",
                color: const Color(0xFF395998),
                icon: const Icon(Icons.facebook, color: Colors.white),
              ),
              const SizedBox(height: 16),

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
