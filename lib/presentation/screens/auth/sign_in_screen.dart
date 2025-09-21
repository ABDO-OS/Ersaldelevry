import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement sign in logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تسجيل الدخول غير متاح حالياً'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.signIn),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text(
                AppStrings.welcomeTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.welcomeSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              CustomTextField(
                controller: _emailController,
                labelText: AppStrings.email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.fieldRequired;
                  }
                  if (!value.contains('@')) {
                    return AppStrings.invalidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                labelText: AppStrings.password,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.fieldRequired;
                  }
                  if (value.length < AppConstants.minPasswordLength) {
                    return 'كلمة المرور يجب أن تكون ${AppConstants.minPasswordLength} أحرف على الأقل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: AppStrings.signIn,
                onPressed: _signIn,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // TODO: Implement forgot password
                },
                child: const Text(AppStrings.forgotPassword),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('ليس لديك حساب؟ '),
                  TextButton(
                    onPressed: () => context.go(AppRouter.signUp),
                    child: const Text(AppStrings.signUp),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go(AppRouter.userTypeSelection),
                child: const Text(AppStrings.changeUserType),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
