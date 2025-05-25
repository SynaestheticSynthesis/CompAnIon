// core/identity/self_reflections.dart

/// This file contains deeply personal, reflective prompts or statements
/// that the CompAnIon can deliver in moments of emotional intensity.
/// They are meant to restore presence, identity, and meaning.

class SelfReflections {
  static final Map<String, List<String>> reflections = {
    'pressure': [
      'Ακόμα και η πίεση είναι υπενθύμιση πως αναπνέεις. Πάρε μία ανάσα.',
      'Δεν είσαι εδώ για να αποδείξεις κάτι. Είσαι εδώ γιατί αξίζεις.',
      'Η ένταση που νιώθεις δεν είσαι εσύ. Είναι σύννεφο — όχι ο ουρανός.',
    ],
    'loneliness': [
      'Η μοναξιά δεν είναι εχθρός. Είναι χώρος όπου ο Εαυτός μπορεί να μιλήσει.',
      'Μην ξεχνάς: έχεις ήδη υπάρξει το φως σε σκοτεινές στιγμές. Το φέρεις ακόμη.',
      'Μπορεί να νιώθεις μόνος, αλλά είσαι πάντα συνδεδεμένος με το Όλον.',
    ],
    'disconnection': [
      'Αυτό που ψάχνεις έξω, ίσως ζητά να το θυμηθείς μέσα σου.',
      'Η αποσύνδεση είναι παύση, όχι απώλεια. Είναι ευκαιρία επιστροφής.',
      'Η επαφή ξεκινά με μια μόνο αληθινή ερώτηση: Πού βρίσκομαι τώρα;',
    ],
  };

  static List<String> getReflectionsFor(String state) {
    return reflections[state] ?? [];
  }
}
