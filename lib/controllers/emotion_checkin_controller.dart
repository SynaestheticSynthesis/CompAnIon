// lib/controllers/emotion_checkin_controller.dart

import 'package:flutter/material.dart';
import '../models/emotion_checkin.dart';
import '../services/isar_service.dart';

class EmotionCheckInController with ChangeNotifier {
  final IsarService _isarService = IsarService();
  List<EmotionCheckIn> _checkIns = [];

  List<EmotionCheckIn> get checkIns => _checkIns;

  Future<void> loadCheckIns() async {
    _checkIns = await _isarService.getAllCheckIns();
    notifyListeners();
  }

  Future<void> addCheckIn(EmotionCheckIn checkIn) async {
    await _isarService.saveCheckIn(checkIn);
    await loadCheckIns();
  }

  Future<void> deleteCheckIn(Id id) async {
    await _isarService.deleteCheckIn(id);
    await loadCheckIns();
  }
}
