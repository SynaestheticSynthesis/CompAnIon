import 'package:flutter/material.dart';
import 'package:companion_core/data/emotion_constants.dart';
import 'package:companion_core/widgets/emotion_option.dart';
import 'package:companion_core/screens/emotion_reflection_screen.dart';
import 'package:companion_core/controllers/emotion_checkin_controller.dart';
import 'package:companion_core/data/app_database.dart';

class EmotionCheckInPage extends StatefulWidget {
  const EmotionCheckInPage({super.key});

  @override
  State<EmotionCheckInPage> createState() => _EmotionCheckInPageState();
}

class _EmotionCheckInPageState extends State<EmotionCheckInPage> {
  String? _selectedValue;

  late final EmotionCheckInController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EmotionCheckInController(AppDatabase());
  }

  void _onTapEmotion(Map<String, dynamic> emotion) {
    final checkIn = EmotionCheckIn(
      emotion: emotion['label'] as String,
      emoji: emotion['emoji'] as String,
      timestamp: DateTime.now(),
      text: '', // or null if you prefer
    );
    _controller.addCheckIn(checkIn);

    setState(() => _selectedValue = emotion['value'] as String);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmotionReflectionScreen(
          emotion: emotion['label'] as String,
          emoji:   emotion['emoji'] as String,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('How are you feeling today?'),
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose the emotion that best describes your moment.",
              style: TextStyle(color: Colors.white70, fontSize: 17, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.builder(
                itemCount: emotionOptions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1.18,
                ),
                itemBuilder: (context, index) {
                  final emotion = emotionOptions[index];
                  return EmotionOption(
                    icon: emotion['icon'] as IconData,
                    label: emotion['label'] as String,
                    selected: emotion['value'] == _selectedValue,
                    onTap: () => _onTapEmotion(emotion),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
