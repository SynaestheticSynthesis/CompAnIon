import 'package:shared_preferences/shared_preferences.dart';
import 'reminder_model.dart';
import 'dart:convert';

class ReminderService {
  static const _key = 'reminders';

  Future<List<ReminderModel>> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr == null) return [];
    final List<dynamic> data = jsonDecode(jsonStr);
    return data.map((e) => ReminderModel.fromJson(e)).toList();
  }

  Future<void> saveReminders(List<ReminderModel> reminders) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(reminders.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonStr);
  }
}