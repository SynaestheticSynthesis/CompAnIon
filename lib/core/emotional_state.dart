class EmotionalState {
  final int stressLevel;       // 0-10
  final int lonelinessLevel;   // 0-10
  final int energyLevel;       // 0-10
  final String context; // Πλαίσιο (π.χ. "work", "home", "social")
  final List<int> stressHistory; // Ιστορικό πίεσης (π.χ. 3 τελευταίες μέρες)

  EmotionalState({
    required this.stressLevel,
    required this.lonelinessLevel,
    required this.energyLevel,
    required this.context,
    this.stressHistory = const [],
  });

  /// Ελέγχει αν υπήρξαν τουλάχιστον 3 συνεχόμενες μέρες με υψηλή πίεση
  bool hasEscalatedStress() {
    return stressHistory.length >= 3 &&
        stressHistory.every((level) => level >= 7);
  }
}