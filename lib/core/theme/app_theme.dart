import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.jabaliBlue,
        primary: AppColors.jabaliBlue,
        secondary: AppColors.jabaliRed,
        error: AppColors.danger,
        surface: AppColors.lightSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
        background: AppColors.lightBackground,
        onBackground: AppColors.lightTextPrimary,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      fontFamily: 'Tajawal',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.jabaliBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: AppColors.lightTextSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.jabaliBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
        bodyMedium: TextStyle(color: AppColors.lightTextPrimary),
        titleLarge: TextStyle(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(color: AppColors.lightTextSecondary),
      ),
      iconTheme: const IconThemeData(color: AppColors.jabaliBlue),
      dividerTheme: const DividerThemeData(color: AppColors.lightBorder),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.jabaliBlue,
        brightness: Brightness.dark,
        primary: AppColors.jabaliBlue,
        secondary: AppColors.jabaliRed,
        error: AppColors.danger,
        surface: AppColors.darkSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
        background: AppColors.darkBackground,
        onBackground: AppColors.darkTextPrimary,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: 'Tajawal',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.jabaliBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        hintStyle: const TextStyle(color: AppColors.darkTextSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.jabaliBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
        titleLarge: TextStyle(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(color: AppColors.darkTextSecondary),
      ),
      iconTheme: const IconThemeData(color: AppColors.jabaliBlue),
      dividerTheme: const DividerThemeData(color: AppColors.darkBorder),
    );
  }
}
