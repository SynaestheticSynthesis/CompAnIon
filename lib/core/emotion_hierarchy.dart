final Map<String, List<String>> emotionHierarchy = {
  'positive': ['grateful', 'hopeful', 'content', 'joyful', 'excited', 'happy'],
  'neutral': ['calm', 'indifferent', 'neutral'],
  'negative': ['tired', 'weary', 'anxious', 'sad', 'disappointed', 'angry'],
  'mixed': ['uncertain', 'conflicted', 'bittersweet']
};

/// Returns the top-level category for a given emotion, or 'mixed' if ambiguous.
String classifyEmotion(String emotion) {
  final e = emotion.toLowerCase();
  for (final entry in emotionHierarchy.entries) {
    if (entry.value.any((v) => e.contains(v))) {
      return entry.key;
    }
  }
  return 'mixed';
}
