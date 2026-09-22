import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:product_explorer/providers/app_providers.dart';
import 'package:product_explorer/screens/auth/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/responsive.dart';
import 'providers/theme_provider.dart';
import 'utils/app_color_sheme.dart';

late AppColorScheme appColors; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  
  ThemeMode initialThemeMode = ThemeMode.system;
  try {
    final prefs = await SharedPreferences.getInstance();
    final modeIndex = prefs.getInt('theme_mode_pref');
    if (modeIndex != null) {
      initialThemeMode = ThemeMode.values[modeIndex];
    }
  } catch (e) {
    debugPrint('Error loading theme preference on launch: $e');
  }
  
  runApp(MultiProvider(
    providers: providers(initialMode: initialThemeMode),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Inter'
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Inter'
      ),
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final brightness = themeProvider.themeMode == ThemeMode.system
            ? MediaQuery.of(context).platformBrightness
            : (themeProvider.themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light);
        appColors = brightness == Brightness.dark ? AppColorScheme.dark : AppColorScheme.light;
        return child!;
      },
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      home: Scaffold(
        body: RegisterScreen()),
    );
  }
}
