// lib/controllers/emotion_checkin_controller.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/emotion_checkin.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../services/hive_service.dart';

class EmotionCheckInController with ChangeNotifier {
  final HiveService _hiveService = HiveService();
  List<EmotionCheckIn> _checkIns = [];

  List<EmotionCheckIn> get checkIns => _checkIns;

  Future<void> loadCheckIns() async {
    _checkIns = await _hiveService.getAllCheckIns();
    notifyListeners();
  }

  Future<void> addCheckIn(EmotionCheckIn checkIn) async {
    await _hiveService.saveCheckIn(checkIn);
    await loadCheckIns();
  }

  Future<void> deleteCheckIn(int key) async {
    await _hiveService.deleteCheckIn(key);
    await loadCheckIns();
  }
}
