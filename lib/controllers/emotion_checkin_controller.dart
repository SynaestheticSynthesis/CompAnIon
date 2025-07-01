// lib/controllers/emotion_checkin_controller.dart

import 'package:flutter/material.dart';
import '../models/emotion_checkin.dart';
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

  Future<void> addCheckIn(EmotionCheckIns checkIn) async {
    await db.insertEmotionCheckIn(checkIn);
    await loadCheckIns();
  }

  Future<void> deleteCheckIn(int id) async {
    await db.deleteEmotionCheckIn(id);
    await loadCheckIns();
  }
}
