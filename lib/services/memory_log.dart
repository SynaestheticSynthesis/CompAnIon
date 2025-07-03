import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/memory_entry.dart';

class MemoryLog {
  static const String _boxName = 'memory_entries';
  static final Uuid _uuid = Uuid();

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MemoryEntryAdapter());
    }
    await Hive.openBox<MemoryEntry>(_boxName);
  }

  static Future<void> add({
    required String type,
    String? note,
  }) async {
    final box = Hive.box<MemoryEntry>(_boxName);
    final entry = MemoryEntry(
      id: _uuid.v4(),
      type: type,
      timestamp: DateTime.now(),
      note: note,
    );
    await box.add(entry);
  }

  static List<MemoryEntry> getRecent({int limit = 10}) {
    final box = Hive.box<MemoryEntry>(_boxName);
    final entries = box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries.take(limit).toList();
  }

  static Future<void> clear() async {
    final box = Hive.box<MemoryEntry>(_boxName);
    await box.clear();
  }
}
