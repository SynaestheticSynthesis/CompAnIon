import 'package:hive/hive.dart';
import '../models/journal_entry.dart';
import '../models/emotion_checkin.dart';


class HiveService {
  static Future<void> init() async {
    Hive.registerAdapter(JournalEntryAdapter());
    await Hive.openBox<JournalEntry>('journal_entries');
  }

  // JournalEntry methods
  Box<JournalEntry> get _journalBox => Hive.box<JournalEntry>('journal_entries');

  Future<void> saveJournalEntry(JournalEntry entry) async {
    await _journalBox.add(entry);
  }

  List<JournalEntry> getAllJournalEntries() {
    return _journalBox.values.toList();
  }

  Future<void> deleteJournalEntry(int key) async {
    await _journalBox.delete(key);
  }
}
