import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('JournalEntry')
class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get text => text()();
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
  TextColumn get text => text().nullable()();
}

@DriftDatabase(tables: [JournalEntries, EmotionCheckIns])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 1;

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
}