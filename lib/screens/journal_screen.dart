import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/journal_entry_controller.dart';
import '../data/app_database.dart'; // Use only app_database.dart for JournalEntry

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late final JournalEntryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = JournalEntryController(AppDatabase());
    _controller.loadEntries();
    _controller.addListener(_onUpdate);
  }

  void _onUpdate() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = _controller.entries;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Reflections'),
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: entries.isEmpty
          ? const Center(
              child: Text(
                'No journal entries yet.\nYour reflections will appear here.',
                style: TextStyle(color: Colors.white70, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];

                return Card(
                  color: Colors.blueGrey.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              entry.emoji ?? '📝',
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              entry.emotion ?? 'No emotion',
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('dd MMM, HH:mm').format(entry.createdAt),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          entry.entryText, // Drift's JournalEntry.entryText is non-nullable
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
