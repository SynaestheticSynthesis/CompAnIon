import 'package:isar/isar.dart';

part 'emotion_checkin.g.dart';

@Collection()
class EmotionCheckIn {
  Id id = Isar.autoIncrement;

  late String emotion;
  late String emoji;
  late DateTime timestamp;
  String? text; // Optional reflection

  EmotionCheckIn();
}

