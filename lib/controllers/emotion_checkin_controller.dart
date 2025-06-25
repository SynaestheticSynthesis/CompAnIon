  // lib/controllers/emotion_checkin_controller.dart

  import 'package:flutter/material.dart';
  import '../models/emotion_checkin.dart';

  class EmotionCheckInController with ChangeNotifier {
    final List<EmotionCheckIn> _checkIns = [];

    List<EmotionCheckIn> get checkIns => _checkIns;

    void addCheckIn(EmotionCheckIn checkIn) {
      _checkIns.add(checkIn);
      notifyListeners(); // ενημέρωση UI
    }

    void clearAll() {
      _checkIns.clear();
      notifyListeners();
    }

  // Μελλοντικά: save to local storage ή cloud
  }
