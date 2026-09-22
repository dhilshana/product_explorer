import 'package:flutter/material.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Icon labelIcon;
  final TextEditingController controller;
  const new({super.key,
  required this.label,
  required this.hintText,
  required this.labelIcon,
  required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        hintText: hintText,
        hintStyle: AppFonts.body(color: appColors.hintColor),
        labelText: label,
        labelStyle: AppFonts.button(color: appColors.textSecondaryColor),
        prefixIcon: labelIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          gapPadding: 0,
          borderSide: BorderSide(
            color: appColors.primaryColor
          )
        ),
        focusColor: appColors.primaryColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(
            color: appColors.borderColor
          )
        )
      ),
    );
  }
}