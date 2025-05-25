// lib/main_logic_coordinator.dart

import 'package:companion_ai/logic/emotional_state.dart';
import 'package:companion_ai/logic/supportive_response_engine.dart';
import 'package:companion_ai/logic/trigger_definitions.dart';
import 'package:companion_ai/logic/self_reflections.dart';

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

  String getReflection() {
    return SelfReflections.generateReflection();
  }

  void resetState() {
    emotionalStateManager.reset();
  }
}
