import 'package:companion_core/models/emotion_checkin.dart';
import 'package:flutter/material.dart';
import 'package:companion_core/data/emotion_constants.dart';
import 'package:companion_core/widgets/emotion_option.dart';
import 'package:companion_core/screens/emotion_reflection_screen.dart';
import 'package:companion_core/controllers/emotion_checkin_controller.dart';





class EmotionCheckInPage extends StatefulWidget {
  const EmotionCheckInPage({super.key});

  @override
  State<EmotionCheckInPage> createState() => _EmotionCheckInPageState();
}

class _EmotionCheckInPageState extends State<EmotionCheckInPage> {
  String? _selectedValue;

  final EmotionCheckInController _controller = EmotionCheckInController();


  void _onTapEmotion(Map<String, dynamic> emotion) {
    final checkIn = EmotionCheckIn(
    final checkIn = EmotionCheckIn(
      emotion: emotion['label'] as String,
      emoji: emotion['emoji'] as String,
      // Add the correct named parameters below, each on its own line.
      // For example, if the correct names are 'dateTime' and 'note', use:
      dateTime: DateTime.now(),
      note: '',
    );
    _controller.addCheckIn(checkIn); // ✅ Saved

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
      ),
          itemCount: emotionOptions.length,               // Correct variable name
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: emotionOptions.length,               // ✔️ σωστό όνομα
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
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
    );
  }
}
