import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../services/hive_service.dart';
import 'package:hive/hive.dart';


class JournalEntryController with ChangeNotifier {
  final HiveService _hiveService = HiveService();
  List<JournalEntry> _entries = [];

  List<JournalEntry> get entries => _entries;

  Future<void> loadEntries() async {
    _entries = await _hiveService.getAllJournalEntries();
    notifyListeners();
  }

  Future<void> addEntry(JournalEntry entry) async {
    await _hiveService.saveJournalEntry(entry);
    await loadEntries();
  }

  Future<void> deleteEntry(int key) async {
    await _hiveService.deleteJournalEntry(key);
    await loadEntries();
  }
}