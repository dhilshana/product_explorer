import 'package:flutter/material.dart';
import 'package:product_explorer/helpers/responsive.dart';

class AppFonts{
  static TextStyle appTitle({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(24),
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle screenTitle({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(22),
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle largeHeading({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(20),
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle sectionHeading({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(16),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle productName({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(14),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle body({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(13),
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle smallBody({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(11),
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle caption({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(10),
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle button({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(13),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle price({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(16),
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle productRating({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(10),
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle searchText({
    required Color color,
  }) {
    return TextStyle(
      fontSize: Responsive.font(12),
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}

class AppSpacing {
  // Padding
  // static double paddingSmall = Responsive.width(8);
  // static double paddingMedium = Responsive.width(16);
  // static double paddingLarge = Responsive.width(24);
  static double mainPadding = Responsive.width(16);

  // static double textFieldPadding = Responsive.width(12);

  // Margin
  // static double marginSmall = Responsive.width(8);
  // static double marginMedium = Responsive.width(16);
  // static double marginLarge = Responsive.width(24);

  // Spacing between widgets
  // static double spacingXS = Responsive.width(4);
  // static double spacingS = Responsive.width(8);
  static double spacingM = Responsive.width(16);
  // static double spacingL = Responsive.width(20);
  // static double spacingXL = Responsive.width(32);

}

class AppRadius {
  // Small rounded corners
  static double small = Responsive.width(4);
  static double medium = Responsive.width(8);
  static double large = Responsive.width(16);
  static double extraLarge = Responsive.width(24);

  // Full circle (avatars, chips, round buttons)
  static BorderRadius circle = BorderRadius.all(Radius.circular(Responsive.width(9999)));
}