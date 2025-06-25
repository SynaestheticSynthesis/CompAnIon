import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/emotion_checkin.dart';
import '../models/journal_entry.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initIsar();
  }

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [EmotionCheckInSchema, JournalEntrySchema],
      directory: dir.path,
    );
  }

  // JournalEntry methods
  Future<void> saveJournalEntry(JournalEntry entry) async {
    final isar = await db;
    await isar.writeTxn(() => isar.journalEntrys.put(entry));
  }

  Future<List<JournalEntry>> getAllJournalEntries() async {
    final isar = await db;
    return await isar.journalEntrys.where().sortByTimestampDesc().findAll();
  }

  Future<void> deleteJournalEntry(Id id) async {
    final isar = await db;
    await isar.writeTxn(() => isar.journalEntrys.delete(id));
  }

  Future<void> saveCheckIn(EmotionCheckIn checkIn) async {
    final isar = await db;
    await isar.writeTxn(() => isar.emotionCheckIns.put(checkIn));
  }

  Future<List<EmotionCheckIn>> getAllCheckIns() async {
    final isar = await db;
    return await isar.emotionCheckIns.where().sortByTimestampDesc().findAll();
  }

  Future<void> deleteCheckIn(Id id) async {
    final isar = await db;
    await isar.writeTxn(() => isar.emotionCheckIns.delete(id));
  }
}
