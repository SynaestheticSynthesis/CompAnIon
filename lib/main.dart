import 'package:flutter/material.dart';
import 'screens/awakening_screen.dart';
import 'screens/home_page.dart';
import 'screens/emotion_checkin_screen.dart';
import 'screens/emotion_reflection_screen.dart' as reflection;
import 'screens/journal_screen.dart';
import 'screens/breathing_screen.dart';
import 'controllers/emotion_checkin_controller.dart';
// Remove the old model import and use only the unified one:
import 'models/emotion_checkin.dart';
import 'package:companion_core/screens/reflective_test_screen.dart';

void main() {
  runApp(const CompanionApp());
}

class CompanionApp extends StatelessWidget {
  const CompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CompAnIon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.tealAccent,
          secondary: Colors.amberAccent,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AwakeningScreen(),
        '/home': (context) => const HomePage(),
        '/emotionCheckIn': (context) => const EmotionCheckInPage(),
        '/emotionReflection': (context) => reflection.EmotionReflectionScreen(
              emotion: '',
              emoji: '',
            ), // Placeholder, set real values on navigation
        '/journal': (context) => const JournalScreen(),
        '/breathing': (context) => const BreathingScreen(),
        '/reflective_test': (context) => const ReflectiveTestScreen(),
      },
    );
  }
}