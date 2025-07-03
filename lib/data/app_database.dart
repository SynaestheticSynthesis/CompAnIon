import 'package:drift/drift.dart';
import 'package:drift/native.dart'; // For testing
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('JournalEntry')
class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entryText => text()(); // Renamed from 'text'
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get emotion => text().nullable()();
  TextColumn get emoji => text().nullable()();
}

@DataClassName('EmotionCheckIn')
class EmotionCheckIns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get emotion => text()();
  TextColumn get emoji => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get entryText => text().nullable()(); // Renamed from 'text'
}

@DriftDatabase(tables: [JournalEntries, EmotionCheckIns])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  // For testing
  AppDatabase.forTesting() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  // Migration support (future-proof)
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Add migration logic here for future schema changes
      // Example:
      // if (from == 1) {
      //   await m.addColumn(journalEntries, journalEntries.mood);
      // }
    },
    beforeOpen: (details) async {
      // Optional: Seed data or perform checks
    },
  );

  // CRUD for JournalEntry
  Future<int> insertJournalEntry(JournalEntriesCompanion entry) =>
      into(journalEntries).insert(entry);

  Future<List<JournalEntry>> getAllJournalEntries() =>
      select(journalEntries).get();

  Future deleteJournalEntry(int id) =>
      (delete(journalEntries)..where((tbl) => tbl.id.equals(id))).go();

  // CRUD for EmotionCheckIn
  Future<int> insertEmotionCheckIn(EmotionCheckInsCompanion checkIn) =>
      into(emotionCheckIns).insert(checkIn);

  Future<List<EmotionCheckIn>> getAllEmotionCheckIns() =>
      select(emotionCheckIns).get();

  Future deleteEmotionCheckIn(int id) =>
      (delete(emotionCheckIns)..where((tbl) => tbl.id.equals(id))).go();

  // --- Advanced Queries & Analytics ---

  // Count entries per emotion
  Future<Map<String, int>> countJournalEntriesByEmotion() async {
    final rows = await (customSelect(
      'SELECT emotion, COUNT(*) as count FROM journal_entries GROUP BY emotion',
      readsFrom: {journalEntries},
    ).get());
    return {
      for (final row in rows)
        row.data['emotion'] as String? ?? 'Unknown': row.data['count'] as int
    };
  }

  // Get most frequent emotion in journal
  Future<String?> getMostFrequentEmotion() async {
    final rows = await (customSelect(
      'SELECT emotion, COUNT(*) as count FROM journal_entries GROUP BY emotion ORDER BY count DESC LIMIT 1',
      readsFrom: {journalEntries},
    ).get());
    if (rows.isNotEmpty) {
      return rows.first.data['emotion'] as String?;
    }
    return null;
  }

  // Average stress/energy/loneliness over time (if you add such fields)
  // Example for EmotionCheckIn: count per day
  Future<List<Map<String, dynamic>>> countCheckInsPerDay() async {
    final rows = await (customSelect(
      '''
      SELECT DATE(timestamp) as day, COUNT(*) as count
      FROM emotion_check_ins
      GROUP BY day
      ORDER BY day DESC
      ''',
      readsFrom: {emotionCheckIns},
    ).get());
    return rows.map((row) => row.data).toList();
  }

  // Get all check-ins for a specific emotion
  Future<List<EmotionCheckIn>> getCheckInsByEmotion(String emotion) {
    return (select(emotionCheckIns)..where((tbl) => tbl.emotion.equals(emotion))).get();
  }
}