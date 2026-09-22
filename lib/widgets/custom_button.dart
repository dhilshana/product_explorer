import 'package:flutter/material.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/utils/theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const new({super.key, 
  required this.label,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.medium))
        ),
        onPressed: onTap, 
        child: Text(label)
      ),
    );
  }
}