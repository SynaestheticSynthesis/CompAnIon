import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/journal_entry_controller.dart';
import '../models/journal_entry.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final JournalEntryController _controller = JournalEntryController();

  @override
  void initState() {
    super.initState();
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
        title: const Text('Journal Entries'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.black,
      body: entries.isEmpty
          ? const Center(
        child: Text(
          'There are no journal entries yet.',
          style: TextStyle(color: Colors.white70),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];

          return Card(
            color: Colors.blueGrey.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        entry.emoji ?? '',
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        entry.emotion ?? '',
                        style: const TextStyle(
                          fontSize: 18,
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
                  const SizedBox(height: 12),
                  Text(
                    entry.text ?? '', // Provide a default value if null
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
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
