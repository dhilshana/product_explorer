import 'package:flutter/material.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/utils/theme.dart';

class CustomIconButton extends StatelessWidget {
  final String label;
  final String icon;
  const new({super.key,
  required this.label,
  required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: appColors.borderColor,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.large))
        ),
        onPressed: (){}, 
        label: Text(label, style: AppFonts.button(color: appColors.primaryColor),),
        icon: Image.asset(icon, height: 20, width: 20,),
      ),
    );
  }
}