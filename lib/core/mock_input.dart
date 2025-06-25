// lib/core/mock_input.dart

import 'dart:async';
import 'dart:math';

import 'companion_core.dart';
import 'emotional_state.dart';

class MockSensorInput {
  final CompanionCore core;
  final Random _random = Random();
  Timer? _timer;

  MockSensorInput(this.core);

  void start() {
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      int stress = _random.nextInt(100);
      int loneliness = _random.nextInt(100);

      print("\n[Mock Data] Stress: $stress | Loneliness: $loneliness");

      core.updateStress(stress);
      core.updateLoneliness(loneliness);
    });
  }

  void stop() {
    _timer?.cancel();
    print("\n[Mock Sensor]: Stopped");
  }
}

class MockInput extends EmotionalState {
  MockInput({
    required int stressLevel,
    required int lonelinessLevel,
    required int energyLevel,
    required String context,
  }) : super(
          stressLevel: stressLevel,
          lonelinessLevel: lonelinessLevel,
          energyLevel: energyLevel,
          context: context,
        );

  // Δημιουργεί ένα τυχαίο input
  static MockInput generateRandom() {
    return MockInput(
      stressLevel: 3 + (DateTime.now().second % 8),
      lonelinessLevel: 2 + (DateTime.now().second % 9),
      energyLevel: 5 + (DateTime.now().second % 6),
      context: "random",
    );
  }

  // Δημιουργεί input από κείμενο (απλοποιημένο παράδειγμα)
  static MockInput fromText(String text) {
    return MockInput(
      stressLevel: text.contains("πίεση") ? 9 : 3,
      lonelinessLevel: text.contains("μόνος") ? 8 : 2,
      energyLevel: text.contains("κούραση") ? 2 : 8,
      context: "user",
    );
  }
}
