import 'package:flutter/material.dart';
import 'package:product_explorer/viewmodels/auth_viewmodel.dart';
import 'package:product_explorer/viewmodels/favorites_viewmodel.dart';
import 'package:product_explorer/viewmodels/product_viewmodel.dart';
import 'package:product_explorer/viewmodels/theme_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders({ThemeMode? initialMode}) => [
      ChangeNotifierProvider(create: (_) => ThemeViewModel(initialMode: initialMode)),
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
    ];
