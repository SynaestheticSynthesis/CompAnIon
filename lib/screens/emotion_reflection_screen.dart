import 'package:flutter/material.dart';
import 'package:companion_core/screens/journal_screen.dart';

import '../models/journal_entry_model.dart';

// Global list to store journal entries
final List<JournalEntry> journalEntries = [];

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

  void _continueToJournal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JournalScreen(
          emotion: widget.emotion,
          emoji: widget.emoji,
          text: _textController.text,
          createdAt: DateTime.now(),
        ),
      ),
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

                  journalEntries.add(entry);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JournalScreen(
                        emotion: widget.emotion,
                        emoji: widget.emoji,
                        text: _textController.text,
                        createdAt: DateTime.now(),
                      ),
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

class JournalScreen extends StatelessWidget {
  final String emotion;
  final String emoji;
  final String text;
  final DateTime createdAt;

  const JournalScreen({
    Key? key,
    required this.emotion,
    required this.emoji,
    required this.text,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$emoji $emotion',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Created at: ${createdAt.toLocal()}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
