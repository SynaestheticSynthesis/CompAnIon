import 'package:hive/hive.dart';

part 'journal_entry.g.dart';


@HiveType(typeId: 0)
class JournalEntry extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  String? emotion;

  @HiveField(3)
  String? emoji;

  JournalEntry({
    required this.text,
    required this.createdAt,
    this.emotion,
    this.emoji,
  });
}
