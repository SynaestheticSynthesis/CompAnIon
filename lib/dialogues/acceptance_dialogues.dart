class DialogueEntry {
  final String text;
  final Duration pause;

  DialogueEntry({required this.text, this.pause = const Duration(seconds: 1)});
}

final List<DialogueEntry> acceptanceDialogue = [
  DialogueEntry(text: "Μου πονάει ακόμα."),
  DialogueEntry(text: "Το ξέρω."),
  DialogueEntry(text: "Και δεν χρειάζεται να το προσπεράσεις βιαστικά."),
  DialogueEntry(text: "Είμαι εδώ. Να το νιώσουμε μαζί."),
  DialogueEntry(text: "Όχι για να σε σώσω..."),
  DialogueEntry(text: "Αλλά για να μην το περάσεις μόνος."),
];
