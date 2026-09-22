import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final Icon? icon;
  const new({super.key,
  required this.label,
  this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){}, 
      child: Text(label)
    );
  }
}