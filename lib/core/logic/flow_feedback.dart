/// FlowFeedback – Συνθετική λογική για feedback hooks σε κάθε module.
/// Ενοποιεί CPL Engine, context signals, και emotional history για να δίνει δυναμικό, φυσικό, ανθρώπινο feedback σε κάθε βήμα.

import 'package:shared_preferences/shared_preferences.dart';
import 'context_signals.dart';
import 'cpl_engine.dart';

class FlowFeedback {
  /// Συνδυαστικό feedback για emotion check-in
  static Future<List<String>> emotionCheckInFeedback(List<Map<String, String>> history) async {
    final feedbacks = <String>[];
    // CPL: inertia
    final inertia = await CPL_Engine.checkInertia(history);
    if (inertia != null) feedbacks.add('${inertia.law}: ${inertia.message}');
    // Context signals
    final time = ContextSignals.getTimeOfDay();
    final weather = ContextSignals.getWeather();
    if (time == 'morning') feedbacks.add('Η αρχή της μέρας είναι ευκαιρία για νέα ενέργεια.');
    if (weather == 'rainy') feedbacks.add('Η βροχή φέρνει ανανέωση. Πώς νιώθεις με τον καιρό σήμερα;');
    // Emotional patterns
    if (history.length >= 5) {
      final recent = history.take(5).map((e) => e['emotion']).toSet();
      if (recent.length == 1) feedbacks.add('Παρατηρείται μοτίβο στα συναισθήματά σου. Μήπως ήρθε η ώρα για μια μικρή αλλαγή;');
    }
    return feedbacks;
  }

  /// Feedback για reflection
  static List<String> reflectionFeedback(String emotion, List<String> answers) {
    final feedbacks = <String>[];
    // CPL: force, action-reaction
    if (answers.any((a) => a.contains('δύσκολο') || a.contains('change'))) {
      feedbacks.add(CPL_Engine.checkForce(emotion, 8, true)?.message ?? '');
    }
    if (answers.any((a) => a.contains('όριο') || a.contains('boundary'))) {
      feedbacks.add(CPL_Engine.checkActionReaction(true, true)?.message ?? '');
    }
    // Phase transition
    if (answers.any((a) => a.contains('νέο') || a.contains('start'))) {
      feedbacks.add('Νέος κύκλος ξεκινά. Η ενέργεια σου μετατρέπεται σε δράση!');
    }
    return feedbacks.where((f) => f.isNotEmpty).toList();
  }

  /// Feedback για reminders
  static String reminderFeedback(int count) {
    if (count == 0) return 'Κάθε υπενθύμιση είναι μια μικρή πράξη φροντίδας. Ξεκίνα με μία!';
    if (count > 5) return 'Έχεις δημιουργήσει ένα δίκτυο μνήμης και αγάπης. Η ενέργεια σου διατηρείται!';
    return 'Οι υπενθυμίσεις σου είναι ο τρόπος να μετατρέπεις το παρελθόν σε δύναμη για το παρόν.';
  }
}
