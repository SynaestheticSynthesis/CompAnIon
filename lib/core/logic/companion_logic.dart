import '../emotional_state.dart';
import 'response_scenarios.dart';

String generateResponse(EmotionalState state) {
  final scenarios = ResponseScenarios();

  if (state.hasEscalatedStress()) {
    return scenarios.escalatedStressSupport(state);
  }

  if (state.stressLevel >= 7) {
    return scenarios.stressSupport(state);
  }

  if (state.lonelinessLevel >= 7) {
    return scenarios.lonelinessSupport(state);
  }

  if (state.energyLevel <= 3) {
    return scenarios.lowEnergySupport(state);
  }

  return scenarios.defaultSupport(state);
}
