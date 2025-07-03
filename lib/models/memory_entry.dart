import 'package:hive/hive.dart';

part 'memory_entry.g.dart';

@HiveType(typeId: 0)
class MemoryEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type; // e.g. 'awakening', 'emotionCheckIn'

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  final String? note;

  MemoryEntry({
    required this.id,
    required this.type,
    required this.timestamp,
    this.note,
  });
}
