class EmotionalState {
  final int stressLevel;       // 0-10
  final int lonelinessLevel;   // 0-10
  final int energyLevel;       // 0-10
  final List<int> stressHistory; // Ιστορικό πίεσης (π.χ. 3 τελευταίες μέρες)

  EmotionalState({
    required this.stressLevel,
    required this.lonelinessLevel,
    required this.energyLevel,
    this.stressHistory = const [],
  });

  /// Ελέγχει αν υπήρξαν τουλάχιστον 3 συνεχόμενες μέρες με υψηλή πίεση
  bool hasEscalatedStress() {
    return stressHistory.length >= 3 &&
        stressHistory.every((level) => level >= 7);
  }
}
