/// CompAnIon Physics Layer (CPL) – Κινηματική Συνείδηση της Ψυχής
/// Εμπνέεται από τους νόμους της φυσικής, αλλά δίνει ποιητικό feedback στον χρήστη.

import 'package:shared_preferences/shared_preferences.dart';

class CPLFeedback {
  final String law;
  final String message;
  CPLFeedback(this.law, this.message);
}

class CPL_Engine {
  /// 1ος Νόμος – Αδράνεια της Συνήθειας
  static Future<CPLFeedback?> checkInertia(List<Map<String, String>> history) async {
    if (history.length < 5) return null;
    final recent = history.take(5).map((e) => e['emotion']).toSet();
    if (recent.length == 1) {
      return CPLFeedback(
        'Νόμος Αδράνειας',
        'Είσαι σε τροχιά. Μήπως ήρθε η ώρα να δώσεις μια ώθηση;'
      );
    }
    return null;
  }

  /// 2ος Νόμος – Δύναμη Συνειδητής Απόφασης
  static CPLFeedback? checkForce(String lastEmotion, int stressLevel, bool intentToChange) {
    if (stressLevel > 7 && intentToChange) {
      return CPLFeedback(
        'Νόμος Δύναμης',
        'Αυτή η δύναμη που ένιωσες δεν είναι πίεση. Είναι ένδειξη ότι κουβαλάς κάτι μεγάλο. Και τώρα το μετακινείς.'
      );
    }
    return null;
  }

  /// 3ος Νόμος – Δράση και Ψυχική Αντίδραση
  static CPLFeedback? checkActionReaction(bool setBoundary, bool noticedPushback) {
    if (setBoundary && noticedPushback) {
      return CPLFeedback(
        'Νόμος Δράσης–Αντίδρασης',
        'Αυτό που βλέπεις δεν είναι απόρριψη. Είναι το σύστημα που δεν ξέρει να χορεύει με καινούργια μουσική. Μη σταματάς.'
      );
    }
    return null;
  }

  /// 4ος Νόμος – Αρχή της Σχετικότητας (Einstein)
  /// Η εμπειρία και η αλήθεια εξαρτώνται από το πλαίσιο και τον παρατηρητή.
  /// CompAnIon μπορεί να δώσει feedback όταν ο χρήστης συγκρίνει τον εαυτό του με άλλους ή νιώθει "πίεση" από εξωτερικά standards.
  static CPLFeedback? checkRelativity({required bool comparingSelf, required bool feelingJudged}) {
    if (comparingSelf || feelingJudged) {
      return CPLFeedback(
        'Αρχή της Σχετικότητας',
        'Η αλήθεια σου είναι μοναδική. Μην κρίνεις την πορεία σου με βάση άλλους. Το πλαίσιο σου είναι δικό σου.'
      );
    }
    return null;
  }

  /// 5ος Νόμος – Αρχή της Αβεβαιότητας (Heisenberg)
  /// Δεν μπορείς να γνωρίζεις τα πάντα ταυτόχρονα. Η αβεβαιότητα είναι μέρος της ζωής.
  /// CompAnIon μπορεί να δώσει feedback όταν ο χρήστης νιώθει μπλοκαρισμένος ή αβέβαιος για το μέλλον.
  static CPLFeedback? checkUncertainty({required bool feelingStuck, required bool futureUnknown}) {
    if (feelingStuck || futureUnknown) {
      return CPLFeedback(
        'Αρχή Αβεβαιότητας',
        'Δεν χρειάζεται να ξέρεις τα πάντα. Η αβεβαιότητα είναι χώρος για δημιουργία και ελευθερία.'
      );
    }
    return null;
  }

  /// 6ος Νόμος – Αρχή της Ελάχιστης Δράσης
  /// Το σύστημα επιλέγει τη διαδρομή με τη λιγότερη αντίσταση.
  /// CompAnIon μπορεί να δώσει feedback όταν ο χρήστης επιλέγει μικρά, απλά βήματα αντί για μεγάλες αλλαγές.
  static CPLFeedback? checkLeastAction({required bool takingSmallSteps}) {
    if (takingSmallSteps) {
      return CPLFeedback(
        'Αρχή Ελάχιστης Δράσης',
        'Κάθε μικρό βήμα είναι σημαντικό. Η πρόοδος δεν χρειάζεται να είναι δραματική για να είναι αληθινή.'
      );
    }
    return null;
  }
}
