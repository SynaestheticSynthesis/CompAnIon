// lib/core/context/companion_context_engine.dart

import 'package:flutter/material.dart';

class CompanionContextEngine {
  final String emotion;
  final TimeOfDay time;
  final bool isAlone;

  CompanionContextEngine({
    required this.emotion,
    required this.time,
    required this.isAlone,
  });

  String getGuidingMessage() {
    // Basic emotional logic
    if (emotion == 'lonely') {
      return isAlone
          ? "Είμαι εδώ. Δεν χρειάζεται να κρατάς τα πάντα μόνος σου."
          : "Ακόμα κι όταν δεν το βλέπεις, υπάρχει κάποιος δίπλα σου.";
    } else if (emotion == 'stressed') {
      if (time.hour < 12) {
        return "Πάρε μια ανάσα. Η μέρα δεν σε κυνηγά, εσύ οδηγείς.";
      } else {
        return "Μπορείς να σταθείς ξανά. Δεν χρειάζεται να είσαι τέλειος, μόνο αληθινός.";
      }
    } else if (emotion == 'anxious') {
      return "Κοίτα γύρω σου. Τίποτα δεν ζητά από σένα να προβλέψεις το μέλλον.";
    } else if (emotion == 'grounded') {
      return "Το νιώθεις αυτό; Είσαι παρών. Και αυτό αρκεί.";
    }

    return "Δεν χρειάζεται να βιαστείς να έχεις απάντηση. Μπορούμε να περιμένουμε μαζί.";
  }
}
