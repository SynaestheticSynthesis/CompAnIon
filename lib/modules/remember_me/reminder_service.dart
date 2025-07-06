import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'reminder_model.dart';

class ReminderService {
  static const _key = 'remember_me_reminders';

  Future<List<ReminderModel>> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw.map((e) => ReminderModel.fromJson(json.decode(e))).toList();
  }

  Future<void> saveReminders(List<ReminderModel> reminders) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, reminders.map((e) => json.encode(e.toJson())).toList());
  }
}
