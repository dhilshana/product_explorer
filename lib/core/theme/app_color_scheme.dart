import 'package:flutter/material.dart';

class AppColorScheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color textColor;
  final Color textSecondaryColor;
  final Color borderColor;
  final Color hintColor;
  final Color redColor;
  final Color ratingGold;
  final Color bannerBg;
  final Color chipBg;
  final Color cardColor;

  const AppColorScheme({
    required this.primaryColor,
    this.secondaryColor = const Color(0xFFF9FAFB),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.surfaceColor = const Color(0xFFF8F9FA),
    required this.textColor,
    required this.textSecondaryColor,
    required this.borderColor,
    required this.hintColor,
    required this.redColor,
    this.ratingGold = const Color(0xFFFBBF24),
    this.bannerBg = const Color(0xFFEEF0FE),
    this.chipBg = const Color(0xFFF1F5F9),
    this.cardColor = const Color(0xFFFFFFFF),
  });

  // ✅ Light Scheme
  static const AppColorScheme light = AppColorScheme(
    primaryColor: Color(0xFF5F5EF5),
    secondaryColor: Color(0xFFF9FAFB),
    backgroundColor: Color(0xFFFFFFFF),
    surfaceColor: Color(0xFFF8F9FA),
    textColor: Color(0xFF17233C),
    textSecondaryColor: Color(0xFF6B7890),
    borderColor: Color(0xFFC7CCD3),
    hintColor: Color(0xFF9AA6B8),
    redColor: Color(0xFFE14646),
    ratingGold: Color(0xFFFBBF24),
    bannerBg: Color(0xFFEEF0FE),
    chipBg: Color(0xFFF1F5F9),
    cardColor: Color(0xFFFFFFFF),
  );

  // ✅ Dark Scheme
  static const AppColorScheme dark = AppColorScheme(
    primaryColor: Color(0xFF4B4AE5),
    secondaryColor: Color(0xFF1E1E1E),
    backgroundColor: Color(0xFF121212),
    surfaceColor: Color(0xFF1E1E1E),
    textColor: Color(0xFFFFFFFF),
    textSecondaryColor: Color(0xFF9CA3AF),
    borderColor: Color(0xFF334155),
    hintColor: Color(0xFF94A3B8),
    redColor: Color(0xFFEF5350),
    ratingGold: Color(0xFFFBBF24),
    bannerBg: Color(0xFF1E213A),
    chipBg: Color(0xFF1E293B),
    cardColor: Color(0xFF1E1F24),
  );
}
