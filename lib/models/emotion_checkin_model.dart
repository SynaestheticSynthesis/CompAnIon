class EmotionCheckIn {
  final String label; // π.χ. "Λύπη", "Ευγνωμοσύνη"
  final String icon;  // π.χ. "😢"
  final DateTime timestamp;
  final int intensity; // από 1 έως 5 (προαιρετικό για τώρα)
  final String? note; // μικρή σημείωση από χρήστη (προαιρετικό)

  EmotionCheckIn({
    required this.label,
    required this.icon,
    required this.timestamp,
    this.intensity = 3,
    this.note,
  });
}

class EmotionCheckInModel {
  final String emotionLabel;
  final String emotionIcon;
  final DateTime timestamp;
  final String? note;

  EmotionCheckInModel({
    required this.emotionLabel,
    required this.emotionIcon,
    required this.timestamp,
    this.note,
  });
}
