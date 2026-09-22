import 'package:flutter/material.dart';
import 'package:product_explorer/main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.arrow_back, color: appColors.textColor,),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}