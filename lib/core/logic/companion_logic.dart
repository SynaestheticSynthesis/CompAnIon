import '../emotional_state.dart';
import '../core/presence_mode.dart';

class ResponseScenarios {
  String escalatedStressSupport(EmotionalState state) => "Υποστήριξη για κλιμακούμενο στρες.";
  String stressSupport(EmotionalState state) => "Υποστήριξη για στρες.";
  String lonelinessSupport(EmotionalState state) => "Υποστήριξη για μοναξιά.";
  String lowEnergySupport(EmotionalState state) => "Βλέπω ότι νιώθεις κουρασμένος. Μπορείς να κάνεις ένα μικρό διάλειμμα ή να φροντίσεις τον εαυτό σου; Είμαι εδώ για σένα.";
  String defaultSupport(EmotionalState state) => "Γενική υποστήριξη.";
  String getCompanionResponse(EmotionalState state) {
    // Example logic for companion response
    if (state.stressLevel > 7) {
      return "Φαίνεται ότι έχεις υψηλό στρες. Θέλεις να μιλήσουμε για αυτό;";
    }
    if (state.energyLevel <= 3) {
      return "Βλέπω ότι νιώθεις κουρασμένος. Θέλεις να κάνουμε μια μικρή παύση ή να πάρεις μερικές ανάσες;";
    }
    return "Είμαι εδώ για σένα, πώς μπορώ να σε βοηθήσω σήμερα;"; 
}

class CompanionLogic {
  String? analyze(EmotionalState state) {
    // Example logic
    if (state.stressLevel > 7) {
      return "Υψηλό στρες ανιχνεύθηκε.";
    }
    return null;
  }
}

String generateResponse(EmotionalState state, {PresenceMode mode = PresenceMode.gentle}) {
  final scenarios = ResponseScenarios();

  try {
    if (mode == PresenceMode.silent) {
      return "Είμαι εδώ αν με χρειαστείς.";
    }
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
    if (mode == PresenceMode.active) {
      return "Θυμήσου: είμαι πάντα δίπλα σου, ό,τι κι αν νιώθεις.";
    }
    return scenarios.defaultSupport(state);
  } catch (e) {
    print('[CompAnIon Logic Error]: $e');
    return "Δεν μπόρεσα να βρω κατάλληλη υποστήριξη αυτή τη στιγμή. Είμαι εδώ αν θέλεις να μιλήσουμε.";
  }
}
  }
}
