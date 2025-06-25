import 'package:isar/isar.dart';

part 'journal_entry.g.dart';

@Collection()
class JournalEntry {
  Id id = Isar.autoIncrement;

  late String text;
  late DateTime createdAt;
  String? emotion;
  String? emoji;

  JournalEntry();
}
