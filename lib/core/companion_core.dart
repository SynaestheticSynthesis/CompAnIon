// lib/core/companion_core.dart
import 'emotional_state.dart';

class CompanionCore {
  int _stressLevel = 0;
  int _lonelinessLevel = 0;
  int _energyLevel = 10;
  String _currentContext = 'default';

  final List<String> _history = [];

  void updateStress(int level) {
    final validated = level.clamp(0, 10);
    _stressLevel = validated;
    // EmotionalState can be created here if needed for further processing.
    var state = EmotionalState(
      stressLevel: _stressLevel,
      lonelinessLevel: _lonelinessLevel,
      energyLevel: _energyLevel,
      context: _currentContext,
    );
    if (_stressLevel > 8) {
      _notify("Πίεση εντοπίστηκε - Θυμήσου ότι έχεις ξεπεράσει δυσκολότερα.");
      _history.add("[Stress: $_stressLevel] -> Alerted");
    } else if (_stressLevel > 5) {
      _notify("Ήπια πίεση εντοπίστηκε - Κάνε ένα μικρό βήμα πίσω, αν χρειαστεί.");
      _history.add("[Stress: $_stressLevel] -> Alerted");
    } else {
      _history.add("[Stress: $_stressLevel] -> OK");
    }
  }

  void updateLoneliness(int level) {
    final validated = level.clamp(0, 10);
    _lonelinessLevel = validated;
    if (_lonelinessLevel > 7) {
      _notify("Αίσθημα μοναξιάς εντοπίστηκε - Είσαι σημαντικός. Δεν είσαι μόνος.");
      _history.add("[Loneliness: $_lonelinessLevel] -> Alerted");
    } else {
      _history.add("[Loneliness: $_lonelinessLevel] -> OK");
    }
  }

  void setContext(String context) {
    _currentContext = context;
    print("\n[Context] Τρέχον πλαίσιο: $_currentContext");
  }

  void _notify(String message) {
    print("[CompAnIon Alert]: $message");
  }

  void showHistory() {
    print("\n[History Log]:");
    for (var event in _history) {
      print("  $event");
    }
  }
}
