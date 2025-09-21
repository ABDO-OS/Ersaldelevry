import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routing/app_router.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.passwordsDoNotMatch),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      context.read<AuthCubit>().signUpWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            displayName: _nameController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.signUp),
        centerTitle: true,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            context.go(AppRouter.home);
          } else if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? AppStrings.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: LoadingOverlay(
          isLoading: context.select((AuthCubit cubit) => cubit.state.isLoading),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    AppStrings.signUp,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'أدخل اسمك والبريد الإلكتروني وكلمة المرور\nلإنشاء حساب.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    controller: _nameController,
                    labelText: AppStrings.fullName,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.fieldRequired;
                      }
                      if (value.length < AppConstants.minNameLength) {
                        return 'الاسم يجب أن يكون ${AppConstants.minNameLength} أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
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
                    textInputAction: TextInputAction.next,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    labelText: AppStrings.confirmPassword,
                    obscureText: _obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.fieldRequired;
                      }
                      if (value != _passwordController.text) {
                        return AppStrings.passwordsDoNotMatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: AppStrings.signUp,
                    onPressed: _signUp,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('لديك حساب بالفعل؟ '),
                      TextButton(
                        onPressed: () => context.go(AppRouter.signIn),
                        child: const Text(AppStrings.signIn),
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
        ),
      ),
    );
  }
}
