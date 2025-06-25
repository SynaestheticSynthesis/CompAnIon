class EmotionCheckIn {
  final String emotion;
  final String emoji;
  final DateTime timestamp;
  final String text; // <-- Add this field

  EmotionCheckIn({
    required this.emotion,
    required this.emoji,
    required this.timestamp,
    required this.text, // <-- Add this parameter
  });
}

 