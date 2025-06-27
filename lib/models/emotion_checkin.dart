import 'package:hive/hive.dart';

part 'emotion_checkin.g.dart';


@HiveType(typeId: 1)
class EmotionCheckIn extends HiveObject {
  @HiveField(0)
  String emotion;

  @HiveField(1)
  String emoji;

  @HiveField(2)
  DateTime timestamp;

  @HiveField(3)
  String? text;

  EmotionCheckIn({
    required this.emotion,
    required this.emoji,
    required this.timestamp,
    this.text,
  });
}