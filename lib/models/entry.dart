import 'package:isar/isar.dart';

part 'entry.g.dart';

@Collection()
class Entry {
  Id id = Isar.autoIncrement;

  late String emotion;      // mood label
  late String emoji;        // 😊
  late String text;         // journal text
  late DateTime createdAt;

  Entry({
    required this.emotion,
    required this.emoji,
    required this.text,
    required this.createdAt,
  });
}
