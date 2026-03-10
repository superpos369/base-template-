import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0A0E21),
    primaryColor: const Color(0xFF1E90FF),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1E90FF),
      secondary: Color(0xFF00D4FF),
      surface: Color(0xFF1A1F38),
      background: Color(0xFF0A0E21),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Satoshi',
        color: Colors.white70,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Satoshi',
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E90FF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1A1F38).withValues(alpha: 0.6),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
  );
}