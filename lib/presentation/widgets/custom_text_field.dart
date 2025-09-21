import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          borderSide: const BorderSide(color: AppTheme.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          borderSide: const BorderSide(color: AppTheme.primaryGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          borderSide: const BorderSide(color: AppTheme.errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          borderSide: const BorderSide(color: AppTheme.errorRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.defaultPadding,
        ),
      ),
    );
  }
}
