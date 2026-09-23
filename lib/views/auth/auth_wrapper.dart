import 'package:flutter/material.dart';
import 'package:product_explorer/viewmodels/auth_viewmodel.dart';
import 'package:product_explorer/views/auth/login_view.dart';
import 'package:product_explorer/views/auth/splash_view.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  final Widget homeView;

  const AuthWrapper({
    super.key,
    required this.homeView,
  });

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _hasStarted = false;

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();

    // If authenticated, navigate to home/main nav view
    if (authVm.isAuthenticated) {
      return widget.homeView;
    }

    // If not started yet, show splash screen
    if (!_hasStarted) {
      return SplashView(
        onGetStarted: () {
          setState(() {
            _hasStarted = true;
          });
        },
      );
    }

    // Unauthenticated: show login
    return const LoginView();
  }
}
