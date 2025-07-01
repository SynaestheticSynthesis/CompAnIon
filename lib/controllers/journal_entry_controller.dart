import 'package:flutter/material.dart';
import '../data/app_database.dart';

class JournalEntryController with ChangeNotifier {
  final AppDatabase db;
  List<JournalEntry> _entries = [];

  JournalEntryController(this.db);

  List<JournalEntry> get entries => _entries;

  Future<void> loadEntries() async {
    _entries = await db.getAllJournalEntries();
    notifyListeners();
  }

  Future<void> addEntry(JournalEntriesCompanion entry) async {
    await db.insertJournalEntry(entry);
    await loadEntries();
  }

  Future<void> deleteEntry(int id) async {
    await db.deleteJournalEntry(id);
    await loadEntries();
  }
}