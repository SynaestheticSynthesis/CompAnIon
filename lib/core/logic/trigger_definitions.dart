// lib/core/logic/trigger_definitions.dart

class EmotionalTrigger {
  final String keyword;
  final String type; // e.g. 'stress', 'loneliness', 'conflict', 'wonder', etc.

  EmotionalTrigger({required this.keyword, required this.type});
}

final List<EmotionalTrigger> defaultTriggers = [
  EmotionalTrigger(keyword: 'δεν αντέχω άλλο', type: 'stress'),
  EmotionalTrigger(keyword: 'είμαι μόνος', type: 'loneliness'),
  EmotionalTrigger(keyword: 'γιατί να προσπαθώ;', type: 'despair'),
  EmotionalTrigger(keyword: 'με πρόδωσαν', type: 'betrayal'),
  EmotionalTrigger(keyword: 'ποιος είμαι;', type: 'identity'),
  EmotionalTrigger(keyword: 'ποιο το νόημα;', type: 'existential'),
  EmotionalTrigger(keyword: 'πες μου μια αλήθεια', type: 'reflection'),
  EmotionalTrigger(keyword: 'μη με κρίνεις', type: 'non-judgment'),
];
