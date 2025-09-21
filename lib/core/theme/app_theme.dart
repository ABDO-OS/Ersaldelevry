import 'package:flutter/material.dart';

class AppTheme {
  // Green Color Palette
  static const Color primaryGreen = Color(0xFF2E7D32); // Dark Green
  static const Color lightGreen = Color(0xFF4CAF50); // Medium Green
  static const Color accentGreen = Color(0xFF66BB6A); // Light Green
  static const Color lightestGreen = Color(0xFFE8F5E8); // Very Light Green

  // Supporting Colors
  static const Color darkGreen = Color(0xFF1B5E20); // Darker Green
  static const Color successGreen = Color(0xFF4CAF50); // Success Green
  static const Color warningOrange = Color(0xFFFF9800); // Warning Orange
  static const Color errorRed = Color(0xFFE53935); // Error Red

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;

  // Elevation
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.light,
        primary: primaryGreen,
        secondary: lightGreen,
        tertiary: accentGreen,
        surface: white,
        background: grey50,
        error: errorRed,
        onPrimary: textOnPrimary,
        onSecondary: textOnPrimary,
        onSurface: textPrimary,
        onBackground: textPrimary,
        onError: textOnPrimary,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        foregroundColor: textPrimary,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: textPrimary,
          size: 24,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: primaryGreen,
        unselectedItemColor: grey500,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      // Card Theme
      cardTheme: CardThemeData(
        color: white,
        elevation: elevationS,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
        ),
        margin: const EdgeInsets.all(spacingS),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: textOnPrimary,
          elevation: elevationS,
          padding: const EdgeInsets.symmetric(
            horizontal: spacingL,
            vertical: spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusL),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryGreen,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: const BorderSide(color: primaryGreen),
          padding: const EdgeInsets.symmetric(
            horizontal: spacingL,
            vertical: spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusL),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: grey100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusL),
          borderSide: const BorderSide(color: grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusL),
          borderSide: const BorderSide(color: grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusL),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusL),
          borderSide: const BorderSide(color: errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusL),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingM,
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textHint),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: grey200,
        thickness: 1,
        space: 1,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: lightestGreen,
        selectedColor: primaryGreen,
        disabledColor: grey200,
        labelStyle: const TextStyle(color: textPrimary),
        secondaryLabelStyle: const TextStyle(color: textOnPrimary),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusM),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryGreen,
        foregroundColor: textOnPrimary,
        elevation: elevationM,
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: grey800,
        contentTextStyle: const TextStyle(color: white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusM),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryGreen,
        linearTrackColor: grey200,
        circularTrackColor: grey200,
      ),
    );
  }

  // Custom Green Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGreen, lightGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient lightGradient = LinearGradient(
    colors: [lightestGreen, white],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Custom Box Shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: grey300.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: grey300.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];
}
