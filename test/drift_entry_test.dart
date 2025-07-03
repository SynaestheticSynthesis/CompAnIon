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

  test('JournalEntry creation and retrieval', () async {
    final entry = JournalEntriesCompanion.insert(
      entryText: 'Test entry',
      createdAt: DateTime.now(),
      emotion: const Value('Joy'),
      emoji: const Value('😊'),
    );
    final id = await db.insertJournalEntry(entry);
    final entries = await db.getAllJournalEntries();
    expect(entries.length, 1);
    expect(entries.first.entryText, 'Test entry');
    expect(entries.first.emotion, 'Joy');
    expect(entries.first.emoji, '😊');
  });

  test('EmotionCheckIn creation and retrieval', () async {
    final checkIn = EmotionCheckInsCompanion.insert(
      emotion: 'Calm',
      emoji: '🌿',
      timestamp: DateTime.now(),
      entryText: const Value('Feeling calm'),
    );
    final id = await db.insertEmotionCheckIn(checkIn);
    final checkIns = await db.getAllEmotionCheckIns();
    expect(checkIns.length, 1);
    expect(checkIns.first.emotion, 'Calm');
    expect(checkIns.first.emoji, '🌿');
    expect(checkIns.first.entryText, 'Feeling calm');
  });
}
