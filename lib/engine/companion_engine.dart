import '../core/emotional_state.dart';
import '../core/logic/companion_logic.dart';

class CompanionEngine {
  final CompanionLogic _logic = CompanionLogic();

  String process(EmotionalState state) {
    final response = _logic.analyze(state);
    return response ?? "Καμία ανάγκη παρέμβασης αυτή τη στιγμή.";
  }
}
