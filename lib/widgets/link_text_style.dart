import 'package:flutter/material.dart';
import 'package:product_explorer/core/utils/responsive.dart';
import 'package:product_explorer/main.dart';

class LinkTextStyle {
  static TextStyle get style => TextStyle(
        color: appColors.primaryColor,
        fontSize: Responsive.font(13),
        fontWeight: FontWeight.w600,
      );
}