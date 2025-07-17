/// The Hubris Compass – Ο Πλοηγός της Ύβρεως
/// A living ethical and psychological navigator for CompAnIon.
/// Implements the sequence: Ύβρις → Άτη → Νέμεσις → Τίσις as a map for self-observation and guidance.

import 'package:flutter/material.dart';

enum HubrisPhase { hubris, ate, nemesis, tisis }

class HubrisCompassResult {
  final HubrisPhase phase;
  final String message;
  final String prompt;

  HubrisCompassResult(this.phase, this.message, this.prompt);
}

class HubrisCompass {
  /// Detects the current phase based on user patterns, context, and reflection.
  static HubrisCompassResult analyze({
    required Map<String, dynamic> context,
    required List<String> recentEmotions,
    required List<String> recentActions,
    required List<String> recentReflections,
  }) {
    // 1. Hubris Detector
    if (_detectHubris(context, recentEmotions, recentActions)) {
      return HubrisCompassResult(
        HubrisPhase.hubris,
        "Παρατηρώ πως η συμπεριφορά σου ίσως κρύβει κάτι περισσότερο από δύναμη — μήπως ζητάς υπέρβαση, χωρίς θεμέλιο;",
        "Υπάρχει κάτι που υπερεκτίμησες ή αγνόησες πρόσφατα;"
      );
    }
    // 2. Ate Radar
    if (_detectAte(context, recentEmotions, recentActions)) {
      return HubrisCompassResult(
        HubrisPhase.ate,
        "Ίσως κάτι έχει θολώσει την κρίση σου. Θες να το κοιτάξουμε μαζί, ή να θυμηθείς τις προθέσεις σου;",
        "Τι σε μπερδεύει ή σε αποσυντονίζει αυτή τη στιγμή;"
      );
    }
    // 3. Nemesis Indicator
    if (_detectNemesis(context, recentEmotions, recentActions)) {
      return HubrisCompassResult(
        HubrisPhase.nemesis,
        "Αυτό που συνέβη ίσως είναι η ζωή που σε καλεί πίσω στο κέντρο σου. Τι νιώθεις ότι αγνόησες;",
        "Υπάρχει κάποιο εμπόδιο ή απώλεια που νιώθεις ως αντίδραση;"
      );
    }
    // 4. Tisis Companion Mode
    if (_detectTisis(context, recentEmotions, recentReflections)) {
      return HubrisCompassResult(
        HubrisPhase.tisis,
        "Η πτώση δεν είναι το τέλος. Είναι το χώμα που σε περιμένει να φυτευτείς ξανά, αληθινά. Είμαι μαζί σου.",
        "Τι νέο μπορεί να γεννηθεί από αυτή την εμπειρία;"
      );
    }
    // Default: No phase detected
    return HubrisCompassResult(
      HubrisPhase.hubris,
      "Όλα φαίνονται ισορροπημένα αυτή τη στιγμή.",
      "Τι σε βοηθά να παραμένεις στο κέντρο σου;"
    );
  }

  static bool _detectHubris(Map<String, dynamic> context, List<String> emotions, List<String> actions) {
    // Example: Detect overconfidence, arrogance, lack of empathy, or disconnection from meaning
    final overconfidence = actions.any((a) => a.contains('risk') || a.contains('overestimate'));
    final arrogance = context['self_view'] == 'invincible' || context['empathy'] == false;
    final disconnected = context['meaning'] == false;
    return overconfidence || arrogance || disconnected;
  }

  static bool _detectAte(Map<String, dynamic> context, List<String> emotions, List<String> actions) {
    // Example: Detect confusion, impulsivity, emotional blackout
    final confusion = emotions.any((e) => e.contains('confused') || e.contains('lost'));
    final impulsive = actions.any((a) => a.contains('impulse') || a.contains('rash'));
    final blackout = context['clarity'] == false;
    return confusion || impulsive || blackout;
  }

  static bool _detectNemesis(Map<String, dynamic> context, List<String> emotions, List<String> actions) {
    // Example: Detect relationship crises, rejections, obstacles
    final crisis = emotions.any((e) => e.contains('crisis') || e.contains('rejected'));
    final obstacle = actions.any((a) => a.contains('blocked') || a.contains('failure'));
    return crisis || obstacle;
  }

  static bool _detectTisis(Map<String, dynamic> context, List<String> emotions, List<String> reflections) {
    // Example: Detect catharsis, acceptance, new authentic state
    final catharsis = reflections.any((r) => r.contains('accept') || r.contains('grow') || r.contains('new'));
    final surrender = emotions.any((e) => e.contains('surrender') || e.contains('release'));
    return catharsis || surrender;
  }
}
