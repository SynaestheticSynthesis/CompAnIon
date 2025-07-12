/// Action–Reaction Feedback Loop for CompAnIon
/// Implements Newton's Third Law as an emotional mechanism.
/// Modular logic for tracking user "actions" and surfacing "reactions" in the app.

import 'dart:async';

class ActionEvent {
  final String type; // e.g. "set_boundary", "new_start", "truth", "quit_job"
  final DateTime timestamp;
  final String description;
  ActionEvent({required this.type, required this.timestamp, required this.description});
}

class ReactionEvent {
  final String type; // e.g. "external_pressure", "self-doubt", "old_pattern", "unexpected_offer"
  final DateTime timestamp;
  final String description;
  final int intensity; // 1–10 scale
  ReactionEvent({required this.type, required this.timestamp, required this.description, required this.intensity});
}

class ActionReactionModule {
  final List<ActionEvent> _actions = [];
  final List<ReactionEvent> _reactions = [];
  Timer? _monitorTimer;

  /// Log a user action (e.g. emotional check-in, boundary, new start)
  void logAction(String type, String description) {
    _actions.add(ActionEvent(
      type: type,
      timestamp: DateTime.now(),
      description: description,
    ));
    _startReactionMonitor();
  }

  /// Log a reaction (e.g. external event, self-doubt, pressure)
  void logReaction(String type, String description, {int intensity = 5}) {
    _reactions.add(ReactionEvent(
      type: type,
      timestamp: DateTime.now(),
      description: description,
      intensity: intensity,
    ));
  }

  /// Allow user to log a reaction interactively (e.g. via UI)
  void logUserReaction(String description, {int intensity = 5}) {
    logReaction('user_reported', description, intensity: intensity);
  }

  /// Detect reaction patterns from emotion history (e.g. repeated negative emotions)
  void detectReactionFromHistory(List<Map<String, String>> history) {
    if (history.isEmpty) return;
    final last = history.first;
    final emotion = last['emotion']?.toLowerCase() ?? '';
    if (emotion.contains('sad') || emotion.contains('angry') || emotion.contains('anxious')) {
      logReaction('pattern_detected', 'Recent negative emotion: $emotion', intensity: 7);
    } else if (emotion.contains('happy') || emotion.contains('excited')) {
      logReaction('pattern_detected', 'Recent positive emotion: $emotion', intensity: 3);
    }
  }

  /// Returns the latest action and its related reactions (within 72h)
  Map<String, dynamic> getLatestActionReaction() {
    if (_actions.isEmpty) return {};
    final lastAction = _actions.last;
    final windowStart = lastAction.timestamp;
    final windowEnd = windowStart.add(const Duration(hours: 72));
    final relatedReactions = _reactions.where((r) =>
      r.timestamp.isAfter(windowStart) && r.timestamp.isBefore(windowEnd)
    ).toList();
    return {
      'action': lastAction,
      'reactions': relatedReactions,
    };
  }

  /// Starts monitoring for reactions after an action (soft monitoring for 72h)
  void _startReactionMonitor() {
    _monitorTimer?.cancel();
    _monitorTimer = Timer(const Duration(hours: 72), () {
      // After 72h, surface a feedback popup or summary
      // This can be hooked into the UI layer
    });
  }

  /// Generates feedback message for the user based on action–reaction loop
  String getFeedbackMessage() {
    final data = getLatestActionReaction();
    if (data.isEmpty) return '';
    final ActionEvent action = data['action'];
    final List<ReactionEvent> reactions = data['reactions'];
    if (reactions.isEmpty) {
      return "Κάθε φορά που κινείσαι με αλήθεια, το πεδίο θα αντιδράσει. Μην το φοβάσαι.\nΗ ένταση που νιώθεις τώρα είναι το αποτύπωμα της δύναμής σου.";
    }
    final maxIntensity = reactions.map((r) => r.intensity).fold(0, (a, b) => a > b ? a : b);
    return "Action: ${action.description}\n"
      "Reaction(s): ${reactions.map((r) => "${r.type} (${r.intensity}/10)").join(', ')}\n"
      "Ο τρίτος νόμος εκδηλώθηκε: Η αντίδραση δεν είναι λάθος. Είναι απόδειξη πως κινήθηκες πραγματικά.\n"
      "Ένταση: $maxIntensity/10";
  }

  /// Optionally, expose a stream for UI to listen for new reactions
  // Stream<ReactionEvent> get reactionStream => _reactionController.stream;
  // final _reactionController = StreamController<ReactionEvent>.broadcast();

  /// Dispose timer when module is destroyed
  void dispose() {
    _monitorTimer?.cancel();
  }
}
