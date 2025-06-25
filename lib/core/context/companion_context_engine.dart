// lib/core/context/companion_context_engine.dart

import 'package:flutter/material.dart';

enum CompanionEmotion { lonely, stressed, anxious, grounded, unknown }

class CompanionContextEngine {
  final CompanionEmotion emotion;
  final TimeOfDay time;
  final bool isAlone;
  final String locale; // π.χ. 'el' ή 'en'

  CompanionContextEngine({
    required String emotion,
    required this.time,
    required this.isAlone,
    this.locale = 'en',
  }) : emotion = _parseEmotion(emotion);

  static CompanionEmotion _parseEmotion(String value) {
    switch (value.toLowerCase()) {
      case 'lonely':
        return CompanionEmotion.lonely;
      case 'stressed':
        return CompanionEmotion.stressed;
      case 'anxious':
        return CompanionEmotion.anxious;
      case 'grounded':
        return CompanionEmotion.grounded;
      default:
        return CompanionEmotion.unknown;
    }
  }

  String getGuidingMessage() {
    final messages = _localizedMessages[locale] ?? _localizedMessages['en']!;
    switch (emotion) {
      case CompanionEmotion.lonely:
        return isAlone ? messages['lonely_alone']! : messages['lonely_not_alone']!;
      case CompanionEmotion.stressed:
        return time.hour < 12 ? messages['stressed_morning']! : messages['stressed_evening']!;
      case CompanionEmotion.anxious:
        return messages['anxious']!;
      case CompanionEmotion.grounded:
        return messages['grounded']!;
      case CompanionEmotion.unknown:
      default:
        return messages['default']!;
    }
  }
}

const Map<String, Map<String, String>> _localizedMessages = {
  'en': {
    'lonely_alone': "I'm here. You don't have to carry everything alone.",
    'lonely_not_alone': "Even when you don't see it, someone is by your side.",
    'stressed_morning': "Take a breath. The day isn't chasing you, you lead it.",
    'stressed_evening': "You can stand up again. You don't have to be perfect, just real.",
    'anxious': "Look around you. Nothing asks you to predict the future.",
    'grounded': "Do you feel this? You are present. And that's enough.",
    'default': "No need to rush for an answer. We can wait together.",
  },
  'el': {
    'lonely_alone': "Είμαι εδώ. Δεν χρειάζεται να κρατάς τα πάντα μόνος σου.",
    'lonely_not_alone': "Ακόμα κι όταν δεν το βλέπεις, υπάρχει κάποιος δίπλα σου.",
    'stressed_morning': "Πάρε μια ανάσα. Η μέρα δεν σε κυνηγά, εσύ οδηγείς.",
    'stressed_evening': "Μπορείς να σταθείς ξανά. Δεν χρειάζεται να είσαι τέλειος, μόνο αληθινός.",
    'anxious': "Κοίτα γύρω σου. Τίποτα δεν ζητά από σένα να προβλέψεις το μέλλον.",
    'grounded': "Το νιώθεις αυτό; Είσαι παρών. Και αυτό αρκεί.",
    'default': "Δεν χρειάζεται να βιαστείς να έχεις απάντηση. Μπορούμε να περιμένουμε μαζί.",
  }
};
