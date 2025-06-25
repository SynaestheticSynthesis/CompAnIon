class EmotionCheckIn {
  final String label; // π.χ. "Λύπη", "Ευγνωμοσύνη"
  final String icon;  // π.χ. "😢"
  final DateTime timestamp;
  final int intensity; // από 1 έως 5
  final String? note; // μικρή σημείωση από χρήστη (προαιρετικό)

  EmotionCheckIn({
    required this.label,
    required this.icon,
    required this.timestamp,
    this.intensity = 3,
    this.note,
  }) : assert(intensity >= 1 && intensity <= 5, 'Intensity must be between 1 and 5');

  // Προαιρετικά: factory για μετατροπή από "παλιό" μοντέλο αν χρειαστεί
  factory EmotionCheckIn.fromModel({
    required String emotionLabel,
    required String emotionIcon,
    required DateTime timestamp,
    String? note,
    int intensity = 3,
  }) {
    return EmotionCheckIn(
      label: emotionLabel,
      icon: emotionIcon,
      timestamp: timestamp,
      note: note,
      intensity: intensity,
    );
  }
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
