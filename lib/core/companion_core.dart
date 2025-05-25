// lib/core/companion_core.dart

class CompanionCore {
  int _stressLevel = 0;
  int _lonelinessLevel = 0;
  String _currentContext = 'default'; // <-- ΝΕΟ ΠΕΔΙΟ

  final List<String> _history = [];

  void updateStress(int level) {
    var state = EmotionalState(
      stressLevel: _stressLevel,
      lonelinessLevel: _lonelinessLevel,
      context: _currentContext, // <-- ΝΕΟ ΠΕΔΙΟ
    );
    if (level > 80) {
      _notify("Πίεση εντοπίστηκε - Θυμήσου ότι έχεις ξεπεράσει δυσκολότερα.");
      _history.add("[Stress: $level] -> Alerted");
    } else if (level > 50) {
      _notify("Ήπια πίεση εντοπίστηκε - Κάνε ένα μικρό βήμα πίσω, αν χρειαστεί.");
      _history.add("[Stress: $level] -> Alerted");
    } else {
      _history.add("[Stress: $level] -> OK");
    }
  }

  void updateLoneliness(int level) {
    var state = EmotionalState(
      stressLevel: _stressLevel,
      lonelinessLevel: _lonelinessLevel,
      context: _currentContext, // <-- ΝΕΟ ΠΕΔΙΟ
    );
    if (level > 70) {
      _notify("Αίσθημα μοναξιάς εντοπίστηκε - Είσαι σημαντικός. Δεν είσαι μόνος.");
      _history.add("[Loneliness: $level] -> Alerted");
    } else {
      _history.add("[Loneliness: $level] -> OK");
    }
  }

  void _notify(String message) {
    print("[CompAnIon Alert]: $message");
  }

  void showHistory() {
    print("\n[History Log]:");
    for (var event in _history) {
      print("  $event");
    }
    void setContext(String context) {
      _currentContext = context;
      print("\n[Context] Τρέχον πλαίσιο: $_currentContext");
    }
  }
}
