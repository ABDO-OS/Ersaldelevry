import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodly_ui/entry_point.dart';
import '../../components/welcome_text.dart';
import '../../constants.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // TODO: Implement sign in logic

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const EntryPoint()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("تسجيل الدخول"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeText(
                title: "مرحباً بك في تطبيق الطعام",
                text: "أدخل بريدك الإلكتروني وكلمة المرور لتسجيل الدخول",
              ),
              const SizedBox(height: defaultPadding),

              // Sign In Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      validator: emailValidator.call,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(hintText: "البريد الإلكتروني"),
                    ),
                    const SizedBox(height: defaultPadding),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      validator: passwordValidator.call,
                      decoration: InputDecoration(
                        hintText: "كلمة المرور",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: _obscureText
                              ? const Icon(Icons.visibility_off,
                                  color: bodyTextColor)
                              : const Icon(Icons.visibility,
                                  color: bodyTextColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signIn,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("تسجيل الدخول"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding),

              // Sign Up Link
              Center(
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w500),
                    text: "ليس لديك حساب؟ ",
                    children: <TextSpan>[
                      TextSpan(
                        text: "إنشاء حساب",
                        style: const TextStyle(color: primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
