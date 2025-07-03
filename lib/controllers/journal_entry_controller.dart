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

// This controller manages the journal entry data, allowing for loading, adding, and deleting entries.
// It uses the AppDatabase to interact with the underlying database and notifies listeners when data changes
// The controller provides methods to load all entries, add a new entry, and delete an existing entry by its ID.
// The JournalEntryController is designed to be used with a ChangeNotifierProvider in Flutter, allowing the UI to reactively update when the entry data changes.
// The controller is initialized with an instance of AppDatabase, which is used to perform database operations.
// The controller can be used in a Flutter application to manage journal entries, providing a reactive interface for the UI to display and manipulate journal data.\