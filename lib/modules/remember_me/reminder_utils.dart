import 'reminder_model.dart';

String buildHumanReminder(ReminderModel r) {
  if (r.isLoss) {
    return "Σήμερα θα είχε γενέθλια ο/η ${r.name}. Θες να του/της πεις κάτι σιωπηλά ή να ανάψουμε μαζί ένα ‘ψηφιακό κερί’;";  
  }
  return "Θυμάσαι που ${r.memory.isNotEmpty ? r.memory : r.name}... Αύριο/σήμερα γιορτάζει. Ίσως ένα τηλεφώνημα, ένα γράμμα ή μια μικρή πράξη να είναι το δικό σου δώρο σήμερα.";
}
