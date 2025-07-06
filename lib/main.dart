import 'package:flutter/material.dart';
import 'features/emotion_check_in/emotion_check_in_screen.dart';
import 'features/reflection/reflection_screen.dart';
import '../modules/remember_me/remember_me_screen.dart';

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
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    EmotionCheckInScreen(),
    RememberMeScreen(),
  ];

  final List<String> _titles = [
    'Emotion Check-In',
    'Remember Me',
  ];

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
          child: MaterialApp(
            title: 'CompAnIon',
            theme: _lightTheme,
            darkTheme: _darkTheme,
            themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: Text(_titles[_selectedIndex]),
                actions: [
                  IconButton(
                    icon: Icon(_isDark ? Icons.dark_mode : Icons.light_mode),
                    tooltip: _isDark ? 'Switch to Light Theme' : 'Switch to Dark Theme',
                    onPressed: () => setState(() => _isDark = !_isDark),
                  ),
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                      ),
                      child: const Text(
                        'CompAnIon Menu',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.emoji_emotions),
                      title: const Text('Emotion Check-In'),
                      selected: _selectedIndex == 0,
                      onTap: () {
                        setState(() => _selectedIndex = 0);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text('Remember Me'),
                      selected: _selectedIndex == 1,
                      onTap: () {
                        setState(() => _selectedIndex = 1);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              body: _screens[_selectedIndex],
            ),
          ),
        ),
      ),
    );
  }
}
