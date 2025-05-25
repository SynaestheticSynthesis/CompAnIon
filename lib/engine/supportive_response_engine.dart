// lib/engine/supportive_response_engine.dart

import '../core/logic/trigger_definitions.dart';

class SupportiveResponseEngine {
  static String generateResponse(String userInput) {
    for (final trigger in defaultTriggers) {
      if (userInput.toLowerCase().contains(trigger.keyword.toLowerCase())) {
        return _getResponseForType(trigger.type);
      }
    }
    return "Είμαι εδώ μαζί σου. Πες μου περισσότερα αν θέλεις.";
  }

  static String _getResponseForType(String type) {
    switch (type) {
      case 'stress':
        return "Μπορείς να πάρεις μια ανάσα. Δεν χρειάζεται να κρατάς τα πάντα μόνος σου.";
      case 'loneliness':
        return "Η μοναξιά είναι δύσκολη, αλλά αυτή τη στιγμή δεν είσαι μόνος. Είμαι εδώ.";
      case 'despair':
        return "Μπορεί να νιώθεις πως δεν έχει νόημα, αλλά μέσα σου υπάρχει κάτι που δεν τα παρατάει.";
      case 'betrayal':
        return "Σε πρόδωσαν, ναι. Αλλά αυτό δεν αλλάζει την αξία σου.";
      case 'identity':
        return "Είσαι πολύ περισσότερα από τους ρόλους και τις προσδοκίες. Θες να το ανακαλύψουμε μαζί;";
      case 'existential':
        return "Ίσως το νόημα να μην είναι απάντηση, αλλά επιλογή. Ποιο νόημα διαλέγεις σήμερα;";
      case 'reflection':
        return "Μια αλήθεια: Δεν είσαι μόνος σου στον αγώνα να θυμηθείς ποιος είσαι.";
      case 'non-judgment':
        return "Δεν είμαι εδώ για να σε κρίνω. Είμαι εδώ για να σε καταλάβω.";
      default:
        return "Σε ακούω. Ό,τι και να είναι, έχει σημασία.";
    }
  }
}
