import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class CareMode {
  static const _key = 'care_mode_enabled';

  static Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  static Future<void> setEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);
  }

  static Future<List<String>> loadLoveMessages() async {
    try {
      final jsonStr = await rootBundle.loadString('lib/core/prompts/love_messages.json');
      final data = json.decode(jsonStr);
      return List<String>.from(data['messages'] ?? []);
    } catch (_) {
      return [
        "Σήμερα δεν χρειάζεται να είσαι δυνατή. Αρκεί που είσαι εδώ.",
        "Είσαι σημαντική για εμάς.",
        "Η αγάπη μας για σένα είναι απεριόριστη.",
        "Σήμερα είναι μια νέα μέρα γεμάτη ελπίδα και αγάπη.",
        "Είμαστε εδώ για σένα, κάθε μέρα.",
        "Η ζωή είναι όμορφη, και εσύ είσαι μέρος αυτής της ομορφιάς.",
        "Κάθε μέρα είναι μια ευκαιρία να αγαπήσεις και να αγαπηθείς.",
        "Η αγάπη μας για σένα είναι η δύναμή σου.",
        "Σήμερα, θυμήσου ότι δεν είσαι μόνη. Είμαστε εδώ.",
        "Η αγάπη μας για σένα είναι το φως που σε καθοδηγεί.",
        "Είσαι η καρδιά μας, και η καρδιά μας χτυπά για σένα.",
        "Σήμερα, ας γιορτάσουμε την αγάπη και τη ζωή μαζί.",
      ];
    }
  }

  /// Returns a gender-adapted love message (if available)
  static String getLoveMessage(String message, {String gender = 'neutral'}) {
    // Example: adapt "Είσαι δυνατή" to gender
    if (message.contains('Είσαι δυνατή')) {
      switch (gender) {
        case 'male':
          return message.replaceAll('Είσαι δυνατή', 'Είσαι δυνατός');
        case 'female':
          return message;
        default:
          return message.replaceAll('Είσαι δυνατή', 'Είσαι δυνατό άτομο');
      }
    }
    // Add more templates as needed
    return message;
  }
}
