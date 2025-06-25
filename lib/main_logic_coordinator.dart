// lib/main_logic_coordinator.dart

import 'package:companion_core/engine/supportive_response_engine.dart';
import 'package:companion_core/core/logic/trigger_definitions.dart';
import 'package:companion_core/core/identity/self_reflections.dart';
import 'package:companion_core/core/emotional_state.dart';


enum Emotion { neutral, happy, sad, stressed, lonely }

class EmotionalStateManager {
  Emotion _currentEmotion = Emotion.neutral;

  void updateState(Emotion emotion) {
    _currentEmotion = emotion;
  }

  Emotion getCurrentState() {
    return _currentEmotion;
  }

  void reset() {
    _currentEmotion = Emotion.neutral;
  }
}




class SupportiveResponseEngine {
  String generateResponse({
    required Emotion emotion,
    required String triggerMessageKey,
  }) {
    // Example logic: return a message based on emotion and triggerMessageKey
    switch (emotion) {
      case Emotion.happy:
        return "Συγχαρητήρια για τη χαρά σου!";
      case Emotion.sad:
        return "Είμαι εδώ αν θέλεις να μιλήσεις.";
      case Emotion.stressed:
        return "Πάρε μια βαθιά ανάσα, όλα θα πάνε καλά.";
      case Emotion.lonely:
        return "Δεν είσαι μόνος, είμαι εδώ για σένα.";
      default:
        return "Είμαι εδώ για να σε στηρίξω.";
    }
  }
}

// ...existing code...
class SelfReflections {
  String generateReflection(String emotion) {
    // Example logic
    switch (emotion) {
      case 'happy':
        return "Τι έκανε αυτή τη μέρα ξεχωριστή για σένα;";
      case 'sad':
        return "Τι θα μπορούσε να σε βοηθήσει να νιώσεις καλύτερα;";
      default:
        return "Πώς νιώθεις αυτή τη στιγμή;";
    }
  }
}
// ...existing code...

// ...existing code...
class Trigger {
  final RegExp pattern;
  final Emotion emotion;
  final String messageKey;

  Trigger({
    required this.pattern,
    required this.emotion,
    required this.messageKey,
  });
}

// Example triggers list
final List<Trigger> triggers = [
  Trigger(
    pattern: RegExp(r'χαρούμενος|χαρά', caseSensitive: false),
    emotion: Emotion.happy,
    messageKey: 'happy_response',
  ),
  Trigger(
    pattern: RegExp(r'λυπημένος|λύπη', caseSensitive: false),
    emotion: Emotion.sad,
    messageKey: 'sad_response',
  ),
  // Add more triggers as needed
];
// ...existing code...

class MainLogicCoordinator {
  final EmotionalStateManager emotionalStateManager = EmotionalStateManager();
  final SupportiveResponseEngine responseEngine = SupportiveResponseEngine();

  String processInput(String input) {
    final matchedTrigger = triggers.firstWhere(
          (trigger) => trigger.pattern.hasMatch(input),
      orElse: () => Trigger(
        pattern: RegExp(''),
        emotion: Emotion.neutral,
        messageKey: 'default_response',
      ),
    );

    // Update state based on trigger
    emotionalStateManager.updateState(matchedTrigger.emotion);

    // Get current state
    final currentState = emotionalStateManager.getCurrentState();

    // Get supportive response
    final response = responseEngine.generateResponse(
      emotion: currentState,
      triggerMessageKey: matchedTrigger.messageKey,
    );

    return response;
  }

// ...existing code...
String getReflection() {
  final selfReflections = SelfReflections();
  // If you want to pass the current emotion as a string:
  final currentEmotion = emotionalStateManager.getCurrentState().toString().split('.').last;
  return selfReflections.generateReflection(currentEmotion);
}
// ...existing code...
  // Generate a reflection based on the current emotional state 

  void resetState() {
    emotionalStateManager.reset();
  } 
  // Reset the emotional state to neutral
}
// ...existing code...