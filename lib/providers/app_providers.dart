import 'package:flutter/material.dart';
import 'package:product_explorer/providers/auth_controller.dart';
import 'package:product_explorer/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers({ThemeMode? initialMode}) => [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider(create: (_) => AuthController()),
];