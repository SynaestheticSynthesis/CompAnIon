import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/emotion_checkin.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initIsar();
  }

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [EmotionCheckInSchema],
      directory: dir.path,
    );
  }

  Future<void> saveCheckIn(EmotionCheckIn checkIn) async {
    final isar = await db;
    await isar.writeTxn(() => isar.emotionCheckIns.put(checkIn));
  }

  Future<List<EmotionCheckIn>> getAllCheckIns() async {
    final isar = await db;
    return await isar.emotionCheckIns.where().sortByTimestampDesc().findAll();
  }

  Future<void> deleteCheckIn(Id id) async {
    final isar = await db;
    await isar.writeTxn(() => isar.emotionCheckIns.delete(id));
  }
}
