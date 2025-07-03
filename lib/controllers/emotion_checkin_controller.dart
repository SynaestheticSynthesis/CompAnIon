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
// This controller manages the emotion check-in data, allowing for loading, adding, and deleting check-ins.
// It uses the AppDatabase to interact with the underlying database and notifies listeners when data changes.
// The controller provides methods to load all check-ins, add a new check-in,  and delete an existing check-in by its ID.
// The EmotionCheckInController is designed to be used with a ChangeNotifierProvider in Flutter, allowing the UI to reactively update when the check-in data changes.
// The controller is initialized with an instance of AppDatabase, which is used to perform database operations.