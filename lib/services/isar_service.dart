import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/entry.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initIsar();
  }

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [EntrySchema],
      directory: dir.path,
    );
  }

  Future<void> saveEntry(Entry entry) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.entrys.put(entry);
    });
  }

  Future<List<Entry>> getAllEntries() async {
    final isar = await db;
    return await isar.entrys.where().sortByCreatedAtDesc().findAll();
  }

  Future<void> deleteEntry(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.entrys.delete(id);
    });
  }

// Άλλες έξυπνες queries μπορούν να μπουν εδώ (π.χ. getByEmotion)
}
