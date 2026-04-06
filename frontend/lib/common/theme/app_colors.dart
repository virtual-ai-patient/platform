import 'package:flutter/material.dart';

/// Figma-aligned palette: clinical dashboard + simulation (teal brand, deep blue primary).
class AppColors {
  const AppColors._();

  /// Logo / brand accent (teal square in designs).
  static const Color brandTeal = Color(0xFF0D9488);
  static const Color brandTealDark = Color(0xFF0F766E);

  /// Primary actions, links, doctor chat (deep blue).
  static const Color primaryBlue = Color(0xFF005A8C);
  static const Color primaryBlueLight = Color(0xFFE0F0F7);

  static const Color canvasBackground = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;
  static const Color surfaceMuted = Color(0xFFF1F5F9);

  static const Color primaryText = Color(0xFF0F172A);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color tertiaryText = Color(0xFF94A3B8);
  static const Color mutedText = Color(0xFF94A3B8);

  static const Color borderSubtle = Color(0xFFE2E8F0);
  static const Color borderStrong = Color(0xFFCBD5E1);
  static const Color chipBackground = Color(0xFFF1F5F9);
  static const Color chipBorder = Color(0xFFCBD5E1);

  /// Difficulty (Case Library).
  static const Color difficultyEasy = Color(0xFF16A34A);
  static const Color difficultyMedium = Color(0xFFEA580C);
  static const Color difficultyHard = Color(0xFFDC2626);

  static const Color specialtyAccent = Color(0xFF005A8C);

  /// Patient bubble / soft panels.
  static const Color patientBubbleBg = Color(0xFFFFFFFF);
  static const Color doctorBubbleBg = Color(0xFF005A8C);

  /// Semantic.
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerSoftBg = Color(0xFFFEF2F2);
  static const Color warningBg = Color(0xFFFEF9C3);
  static const Color warningBorder = Color(0xFFFDE047);
  static const Color successTeal = Color(0xFF0D9488);

  static const Color heroTint = Color(0xFFE6F7F5);
  static const Color heroTintEnd = Color(0xFFE8F4FA);

  /// Flat separation (avoid heavy Material elevation).
  static const Color shadowHairline = Color(0x140F172A);

  /// Legacy aliases used across older widgets — map to new tokens.
  static const Color brand = brandTeal;
  static const Color background = canvasBackground;
  static const Color heroStart = heroTint;
  static const Color heroEnd = heroTintEnd;
  static const Color border = borderSubtle;
  static const Color borderAlt = borderStrong;
  static const Color dangerText = danger;
  static const Color dangerBg = dangerSoftBg;
  static const Color dangerBorder = Color(0xFFFECACA);
  static const Color shadow = shadowHairline;
}
