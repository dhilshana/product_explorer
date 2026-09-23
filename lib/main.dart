import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_color_scheme.dart';
import 'package:product_explorer/core/utils/responsive.dart';
import 'package:product_explorer/viewmodels/app_providers.dart';
import 'package:product_explorer/viewmodels/theme_viewmodel.dart';
import 'package:product_explorer/views/auth/auth_wrapper.dart';
import 'package:product_explorer/views/main_nav/main_nav_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late AppColorScheme appColors;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization note: $e');
  }

  ThemeMode initialThemeMode = ThemeMode.system;
  try {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt('theme_mode_pref');
    if (modeIndex != null && modeIndex < ThemeMode.values.length) {
      initialThemeMode = ThemeMode.values[modeIndex];
    }
  } catch (e) {
    debugPrint('Error loading theme preference on launch: $e');
  }

  runApp(
    MultiProvider(
      providers: appProviders(initialMode: initialThemeMode),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final themeVm = context.watch<ThemeViewModel>();

    return MaterialApp(
      title: 'Product Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5F5EF5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4B4AE5),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      themeMode: themeVm.themeMode,
      builder: (context, child) {
        final brightness = themeVm.themeMode == ThemeMode.system
            ? MediaQuery.of(context).platformBrightness
            : (themeVm.themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light);
        appColors = brightness == Brightness.dark ? AppColorScheme.dark : AppColorScheme.light;
        return child!;
      },
      home: const AuthWrapper(
        homeView: MainNavView(),
      ),
    );
  }
}
