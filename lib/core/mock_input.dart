// lib/core/mock_input.dart

import 'dart:async';
import 'dart:math';

import 'companion_core.dart';

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
