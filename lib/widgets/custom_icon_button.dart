import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/main.dart';

class CustomIconButton extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback? onTap;

  const CustomIconButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: appColors.borderColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
        ),
        onPressed: onTap ?? () {},
        label: Text(
          label,
          style: AppFonts.button(color: appColors.textColor),
        ),
        icon: Image.asset(
          icon,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}