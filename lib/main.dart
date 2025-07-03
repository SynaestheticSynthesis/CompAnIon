import 'package:flutter/material.dart';
import 'emotion_check_in.dart';

void main() {
  runApp(const CompAnIonApp());
}

class CompAnIonApp extends StatefulWidget {
  const CompAnIonApp({super.key});

  @override
  State<CompAnIonApp> createState() => _CompAnIonAppState();
}

class _CompAnIonAppState extends State<CompAnIonApp> {
  bool _isDark = false;

  // Custom color schemes
  ThemeData get _lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFB2FF59), // light green
        scaffoldBackgroundColor: const Color(0xFFF9FFF3),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFB2FF59), // light green
          secondary: const Color(0xFFFFF176), // yellow accent
          background: const Color(0xFFF9FFF3),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB2FF59),
          foregroundColor: Colors.black,
        ),
        cardColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFF176),
            foregroundColor: Colors.black,
          ),
        ),
      );

  ThemeData get _darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF232946), // deep space blue
        scaffoldBackgroundColor: const Color(0xFF121629),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF232946),
          secondary: const Color(0xFF9F86FF), // violet accent
          background: const Color(0xFF121629),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF232946),
          foregroundColor: Colors.white,
        ),
        cardColor: const Color(0xFF232946),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF9F86FF),
            foregroundColor: Colors.white,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = _isDark ? _darkTheme : _lightTheme;
    final bgColor = theme.scaffoldBackgroundColor;
    return AnimatedTheme(
      data: theme,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      child: Builder(
        builder: (context) => AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          color: bgColor,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 1.0), // subtle scale placeholder
            duration: const Duration(milliseconds: 400),
            builder: (context, scale, child) => Transform.scale(
              scale: scale,
              child: MaterialApp(
                title: 'CompAnIon',
                theme: _lightTheme,
                darkTheme: _darkTheme,
                themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
                home: EmotionCheckInScreen(
                  onToggleTheme: () => setState(() => _isDark = !_isDark),
                  isDark: _isDark,
                ),
                debugShowCheckedModeBanner: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
