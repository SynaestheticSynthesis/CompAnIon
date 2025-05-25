import '../emotional_state.dart';

class EmotionalHistory {
  final List<EmotionalState> _history = [];

  void addState(EmotionalState state) {
    _history.add(state);
    if (_history.length > 50) {
      _history.removeAt(0); // κρατάμε τα τελευταία 50
    }
  }

  bool hasHighStressStreak(int count) {
    return _history.reversed.take(count).every((e) => e.stressLevel > 7);
  }

  bool isLowEnergyFrequent() {
    int lowEnergyDays = _history.where((e) => e.energyLevel < 3).length;
    return lowEnergyDays > (_history.length / 2);
  }

  bool isLonelyStreak(int count) {
    return _history.reversed.take(count).every((e) => e.lonelinessLevel > 7);
  }
}
