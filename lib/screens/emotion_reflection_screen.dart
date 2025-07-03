import 'package:flutter/material.dart';
import 'package:companion_core/screens/journal_screen.dart';

import '../controllers/journal_entry_controller.dart';
import '../data/app_database.dart';

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
  late final JournalEntryController _journalController;

  @override
  void initState() {
    super.initState();
    _journalController = JournalEntryController(AppDatabase());
  }

  void _continueToJournal() async {
    final entry = JournalEntriesCompanion.insert(
      emotion: Value(widget.emotion.isNotEmpty ? widget.emotion : 'No emotion'),
      emoji: Value(widget.emoji.isNotEmpty ? widget.emoji : '📝'),
      entryText: _textController.text.isNotEmpty ? _textController.text : 'No text',
      createdAt: DateTime.now(),
    );

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
        title: const Text("Reflect on your feeling"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.emoji,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Text(
                  "You feel ${widget.emotion}",
                  style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              "Would you like to write a few words about this moment? Anything you share is just for you.",
              style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                style: const TextStyle(color: Colors.white, fontSize: 17),
                decoration: InputDecoration(
                  hintText: "Let your thoughts flow here...",
                  hintStyle: const TextStyle(color: Colors.white38, fontSize: 16),
                  filled: true,
                  fillColor: Colors.blueGrey.shade800,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _continueToJournal,
                icon: const Icon(Icons.favorite, color: Colors.pinkAccent),
                label: const Text(
                  'Save Reflection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent.withOpacity(0.13),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  elevation: 0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}