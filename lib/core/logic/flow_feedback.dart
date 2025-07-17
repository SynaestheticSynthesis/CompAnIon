/// FlowFeedback – Συνθετική λογική για feedback hooks σε κάθε module.
/// Ενοποιεί CPL Engine, context signals, και emotional history για να δίνει δυναμικό, φυσικό, ανθρώπινο feedback σε κάθε βήμα.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'context_signals.dart';
import 'cpl_engine.dart';
import '../../l10n/app_localizations.dart';

class FlowFeedback {
  /// Συνδυαστικό feedback για emotion check-in
  static Future<List<String>> emotionCheckInFeedback(
    List<Map<String, String>> history,
    BuildContext context,
  ) async {
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final feedbacks = <String>[];

    // CPL: inertia
    final inertia = await CPL_Engine.checkInertia(history);
    if (inertia != null) feedbacks.add('${inertia.law}: ${inertia.message}');

    // Context signals
    final time = ContextSignals.getTimeOfDay();
    final weather = ContextSignals.getWeather();
    if (time == 'morning') feedbacks.add(loc.feedbackMorning);
    if (weather == 'rainy') feedbacks.add(loc.feedbackRainy);

    // --- Adaptive feedback additions ---
    if (history.isNotEmpty) {
      final recentEmotions = history.take(5).map((e) => e['emotion'] ?? '').toList();
      final lastEmotion = recentEmotions.isNotEmpty ? recentEmotions.first : '';
      final streakEmotion = recentEmotions.every((e) => e == lastEmotion) ? lastEmotion : null;

      // Streak encouragement or gentle support
      if (streakEmotion != null && streakEmotion.isNotEmpty) {
        if (streakEmotion.contains(loc.happy) || streakEmotion.contains(loc.excited)) {
          feedbacks.add(loc.feedbackStreakPositive);
        } else if (streakEmotion.contains(loc.sad) || streakEmotion.contains(loc.disappointed)) {
          feedbacks.add(loc.feedbackStreakNegative);
        } else if (streakEmotion.contains(loc.angry)) {
          feedbacks.add(loc.feedbackStreakAngry);
        } else if (streakEmotion.contains(loc.anxious)) {
          feedbacks.add(loc.feedbackStreakAnxious);
        }
      }

      // Recent change detection
      if (recentEmotions.length >= 2 && recentEmotions[0] != recentEmotions[1]) {
        feedbacks.add(loc.feedbackRecentChange);
      }

      // Context-aware suggestions
      if (time == 'evening' && lastEmotion.contains(loc.sad)) {
        feedbacks.add(loc.feedbackEveningSad);
      }
      if (weather == 'sunny' && lastEmotion.contains(loc.neutral)) {
        feedbacks.add(loc.feedbackSunnyNeutral);
      }
    }

    // Emotional patterns
    if (history.length >= 5) {
      final recent = history.take(5).map((e) => e['emotion']).toSet();
      if (recent.length == 1) feedbacks.add(loc.feedbackPattern);
    }

    // Human touch: always end with a gentle reminder
    if (locale == 'el') {
      feedbacks.add(loc.feedbackHumanTouch);
    } else {
      // Fallback to English if not already translated
      feedbacks.add('Whatever you feel, I\'m here for you. Every emotion matters.');
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
