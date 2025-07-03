import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:companion_core/data/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting();
  });

  tearDown(() async {
    await db.close();
  });

  test('Empty journal returns empty list', () async {
    final entries = await db.getAllJournalEntries();
    expect(entries, isEmpty);
  });

  test('JournalEntry creation and retrieval', () async {
    final entry = JournalEntriesCompanion.insert(
      entryText: 'Test entry',
      createdAt: DateTime.now(),
      emotion: const Value('Joy'),
      emoji: const Value('😊'),
    );
    await db.insertJournalEntry(entry);
    final entries = await db.getAllJournalEntries();
    expect(entries.length, 1);
    expect(entries.first.entryText, 'Test entry');
    expect(entries.first.emotion, 'Joy');
    expect(entries.first.emoji, '😊');
  });

  test('JournalEntry deletion', () async {
    final entry = JournalEntriesCompanion.insert(
      entryText: 'To be deleted',
      createdAt: DateTime.now(),
      emotion: const Value('Sad'),
      emoji: const Value('😢'),
    );
    final id = await db.insertJournalEntry(entry);
    await db.deleteJournalEntry(id);
    final entries = await db.getAllJournalEntries();
    expect(entries, isEmpty);
  });

  test('Handles null/empty optional fields', () async {
    final entry = JournalEntriesCompanion.insert(
      entryText: 'No emotion or emoji',
      createdAt: DateTime.now(),
    );
    await db.insertJournalEntry(entry);
    final entries = await db.getAllJournalEntries();
    expect(entries.first.emotion, isNull);
    expect(entries.first.emoji, isNull);
  });

  test('Multiple JournalEntries', () async {
    await db.insertJournalEntry(JournalEntriesCompanion.insert(
      entryText: 'First',
      createdAt: DateTime.now(),
      emotion: const Value('Happy'),
      emoji: const Value('🙂'),
    ));
    await db.insertJournalEntry(JournalEntriesCompanion.insert(
      entryText: 'Second',
      createdAt: DateTime.now(),
      emotion: const Value('Tired'),
      emoji: const Value('😴'),
    ));
    final entries = await db.getAllJournalEntries();
    expect(entries.length, 2);
    expect(entries.map((e) => e.entryText), containsAll(['First', 'Second']));
  });

  test('EmotionCheckIn creation and retrieval', () async {
    final checkIn = EmotionCheckInsCompanion.insert(
      emotion: 'Calm',
      emoji: '🌿',
      timestamp: DateTime.now(),
      entryText: const Value('Feeling calm'),
    );
    await db.insertEmotionCheckIn(checkIn);
    final checkIns = await db.getAllEmotionCheckIns();
    expect(checkIns.length, 1);
    expect(checkIns.first.emotion, 'Calm');
    expect(checkIns.first.emoji, '🌿');
    expect(checkIns.first.entryText, 'Feeling calm');
  });

  test('EmotionCheckIn handles null entryText', () async {
    final checkIn = EmotionCheckInsCompanion.insert(
      emotion: 'Lonely',
      emoji: '😔',
      timestamp: DateTime.now(),
    );
    await db.insertEmotionCheckIn(checkIn);
    final checkIns = await db.getAllEmotionCheckIns();
    expect(checkIns.first.entryText, isNull);
  });

  test('EmotionCheckIn deletion', () async {
    final checkIn = EmotionCheckInsCompanion.insert(
      emotion: 'DeleteMe',
      emoji: '❌',
      timestamp: DateTime.now(),
      entryText: const Value('To be deleted'),
    );
    final id = await db.insertEmotionCheckIn(checkIn);
    await db.deleteEmotionCheckIn(id);
    final checkIns = await db.getAllEmotionCheckIns();
    expect(checkIns, isEmpty);
  });
}
