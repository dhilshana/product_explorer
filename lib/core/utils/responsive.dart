import 'package:flutter/material.dart';

class Responsive {
  static double _screenWidth = 392.7;
  static double _screenHeight = 805.09;

  // Base design size (design reference)
  static const double _baseWidth = 392.7;
  static const double _baseHeight = 805.09;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  /// Responsive width (px based on design)
  static double width(double value) {
    return value * (_screenWidth / _baseWidth);
  }

  /// Responsive height (px based on design)
  static double height(double value) {
    return value * (_screenHeight / _baseHeight);
  }

  /// Font scaling
  static double font(double size) {
    return width(size);
  }
}
