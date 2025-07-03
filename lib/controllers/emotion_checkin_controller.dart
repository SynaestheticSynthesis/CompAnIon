// lib/controllers/emotion_checkin_controller.dart

import 'package:flutter/material.dart';
import '../data/app_database.dart';

class EmotionCheckInController with ChangeNotifier {
  final AppDatabase db;
  List<EmotionCheckIn> _checkIns = [];

  EmotionCheckInController(this.db);

  List<EmotionCheckIn> get checkIns => _checkIns;

  Future<void> loadCheckIns() async {
    _checkIns = await db.getAllEmotionCheckIns();
    notifyListeners();
  }

  Future<void> addCheckIn(EmotionCheckIn checkIn) async {
    final companion = EmotionCheckInsCompanion.insert(
      emotion: checkIn.emotion.isNotEmpty ? checkIn.emotion : 'No emotion',
      emoji: checkIn.emoji.isNotEmpty ? checkIn.emoji : '🙂',
      timestamp: checkIn.timestamp,
      text: Value(checkIn.text ?? ''),
    );
    await db.insertEmotionCheckIn(companion);
    await loadCheckIns();
  }

  Future<void> deleteCheckIn(int id) async {
    await db.deleteEmotionCheckIn(id);
    await loadCheckIns();
  }
}
}
}
