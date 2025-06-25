import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../services/isar_service.dart';

class JournalEntryController with ChangeNotifier {
  final IsarService _isarService = IsarService();
  List<JournalEntry> _entries = [];

  List<JournalEntry> get entries => _entries;

  Future<void> loadEntries() async {
    _entries = await _isarService.getAllJournalEntries();
    notifyListeners();
  }

  Future<void> addEntry(JournalEntry entry) async {
    await _isarService.saveJournalEntry(entry);
    await loadEntries();
  }

  Future<void> deleteEntry(Id id) async {
    await _isarService.deleteJournalEntry(id);
    await loadEntries();
  }
}