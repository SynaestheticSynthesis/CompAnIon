import 'package:flutter/material.dart';
import 'package:companion_core/screens/journal_screen.dart';

import '../controllers/journal_entry_controller.dart';
import '../models/journal_entry.dart';


class EmotionReflectionScreen extends StatefulWidget {
  final String emotion;
  final String emoji;

  const EmotionReflectionScreen({
    super.key,
    required this.emotion,
    required this.emoji,
  });

  @override
  State<EmotionReflectionScreen> createState() => _EmotionReflectionScreenState();
}

class _EmotionReflectionScreenState extends State<EmotionReflectionScreen> {
  final TextEditingController _textController = TextEditingController();
  final JournalEntryController _journalController = JournalEntryController();

  void _continueToJournal() async {
    final entry = JournalEntry()
      ..emotion = widget.emotion
      ..text = _textController.text
      ..createdAt = DateTime.now();

    await _journalController.addEntry(entry);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const JournalScreen()),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text("Would you like to reflect?"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.emoji} Νιώθεις ${widget.emotion}",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              "Write down your thoughts or feelings about this emotion.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Write your thoughts here...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Colors.blueGrey.shade800,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  final entry = JournalEntry(
                    emotion: widget.emotion,
                    emoji: widget.emoji,
                    text: _textController.text,
                    createdAt: DateTime.now(),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const JournalScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Compare this snippet from lib/controllers/journal_entry_controller.dart: