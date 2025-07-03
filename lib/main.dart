import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/presence_mode.dart';
import 'screens/awakening_screen.dart';
import 'screens/home_page.dart';
import 'screens/emotion_checkin_screen.dart';
import 'screens/emotion_reflection_screen.dart' as reflection;
import 'screens/journal_screen.dart';
import 'screens/breathing_screen.dart';
import 'controllers/emotion_checkin_controller.dart';
import 'models/emotion_checkin.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/memory_log.dart';
import 'features/story_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await MemoryLog.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => PresenceModeProvider(),
      child: const CompanionApp(),
    ),
  );
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
            ),
        '/journal': (context) => const JournalScreen(),
        '/breathing': (context) => const BreathingScreen(),
        '/story': (context) => const StoryMode(),
      },
    );
  }
}