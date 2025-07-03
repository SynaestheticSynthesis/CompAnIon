export '../data/app_database.dart' show EmotionCheckIn;
class EmotionCheckIn {
  final int? id;
  final String emotion;
  final String emoji;
  final DateTime timestamp;
  final String? text;

  EmotionCheckIn({
    this.id,
    required this.emotion,
    required this.emoji,
    required this.timestamp,
    this.text,
  });
}

// The Drift table for EmotionCheckIn should be defined in app_database.dart

