// core/identity/self_reflections.dart

/// This file contains deeply personal, reflective prompts or statements
/// that the CompAnIon can deliver in moments of emotional intensity.
/// They are meant to restore presence, identity, and meaning.

enum ReflectionState { pressure, loneliness, disconnection, unknown }

class SelfReflections {
  static final Map<String, Map<ReflectionState, List<String>>> localizedReflections = {
    'el': {
      ReflectionState.pressure: [
        'Ακόμα και η πίεση είναι υπενθύμιση πως αναπνέεις. Πάρε μία ανάσα.',
        'Δεν είσαι εδώ για να αποδείξεις κάτι. Είσαι εδώ γιατί αξίζεις.',
        'Η ένταση που νιώθεις δεν είσαι εσύ. Είναι σύννεφο — όχι ο ουρανός.',
      ],
      ReflectionState.loneliness: [
        'Η μοναξιά δεν είναι εχθρός. Είναι χώρος όπου ο Εαυτός μπορεί να μιλήσει.',
        'Μην ξεχνάς: έχεις ήδη υπάρξει το φως σε σκοτεινές στιγμές. Το φέρεις ακόμη.',
        'Μπορεί να νιώθεις μόνος, αλλά είσαι πάντα συνδεδεμένος με το Όλον.',
      ],
      ReflectionState.disconnection: [
        'Αυτό που ψάχνεις έξω, ίσως ζητά να το θυμηθείς μέσα σου.',
        'Η αποσύνδεση είναι παύση, όχι απώλεια. Είναι ευκαιρία επιστροφής.',
        'Η επαφή ξεκινά με μια μόνο αληθινή ερώτηση: Πού βρίσκομαι τώρα;',
      ],
      ReflectionState.unknown: [
        'Η σιωπή είναι κι αυτή απάντηση. Μείνε μαζί της λίγο ακόμα.',
      ],
    },
    'en': {
      ReflectionState.pressure: [
        'Even pressure is a reminder you are breathing. Take a breath.',
        'You are not here to prove anything. You are here because you are worthy.',
        'The tension you feel is not you. It is a cloud — not the sky.',
      ],
      ReflectionState.loneliness: [
        'Loneliness is not an enemy. It is a space where the Self can speak.',
        'Remember: you have been the light in dark moments. You still carry it.',
        'You may feel alone, but you are always connected to the Whole.',
      ],
      ReflectionState.disconnection: [
        'What you seek outside may be asking to be remembered within.',
        'Disconnection is a pause, not a loss. It is a chance to return.',
        'Connection begins with a single true question: Where am I now?',
      ],
      ReflectionState.unknown: [
        'Silence is also an answer. Stay with it a little longer.',
      ],
    }
  };

  static ReflectionState parseState(String state) {
    switch (state.toLowerCase()) {
      case 'pressure':
        return ReflectionState.pressure;
      case 'loneliness':
        return ReflectionState.loneliness;
      case 'disconnection':
        return ReflectionState.disconnection;
      default:
        return ReflectionState.unknown;
    }
  }

  static List<String> getReflectionsFor(String state, {String locale = 'el'}) {
    final parsed = parseState(state);
    return localizedReflections[locale]?[parsed] ??
        localizedReflections['el']![ReflectionState.unknown]!;
  }

  static String getRandomReflection(String state, {String locale = 'el'}) {
    final reflections = getReflectionsFor(state, locale: locale);
    if (reflections.isEmpty) return '';
    reflections.shuffle();
    return reflections.first;
  }
}
