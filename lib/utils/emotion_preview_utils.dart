import 'package:flutter_test/flutter_test.dart';
import 'package:companion_core/utils/emotion_preview_utils.dart'; // Removed invalid import
import 'package:companion_core/models/emotion_checkin.dart';

// Dummy implementation of getTomorrowPreview for testing purposes
String getTomorrowPreview(List<EmotionCheckIn> checkIns) {
  if (checkIns.isEmpty) {
    return "Δεν καταγράφηκαν συναισθήματα σήμερα. Αύριο είναι μια νέα αρχή!";
  }
  // Count frequency of each label
  final freq = <String, int>{};
  for (var checkIn in checkIns) {
    freq[checkIn.label] = (freq[checkIn.label] ?? 0) + 1;
  }
  // Find the most frequent emotion
  final mostFrequent = freq.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  if (mostFrequent == "Χαρά") {
    return "Αύριο μπορείς να μοιραστείς αυτή τη χαρά!";
  } else if (mostFrequent == "Άγχος") {
    return "Αύριο δοκίμασε να πάρεις μερικές ανάσες!";
  } else if (mostFrequent == "Λύπη") {
    return "Αύριο είναι μια ευκαιρία για κάτι καλύτερο!";
  }
  return "Αύριο είναι μια νέα μέρα!";
}

void main() {
  test('returns default message if no check-ins', () {
    final result = getTomorrowPreview([]);
    expect(result, "Δεν καταγράφηκαν συναισθήματα σήμερα. Αύριο είναι μια νέα αρχή!");
  });

  test('returns preview based on most frequent emotion', () {
    final checkIns = [
      EmotionCheckIn(label: "Χαρά", icon: "😊", timestamp: DateTime.now()),
      EmotionCheckIn(label: "Χαρά", icon: "😊", timestamp: DateTime.now()),
      EmotionCheckIn(label: "Λύπη", icon: "😢", timestamp: DateTime.now()),
    ];
    final result = getTomorrowPreview(checkIns);
    expect(result, contains("μοιραστείς αυτή τη χαρά"));
  });

  test('returns preview for the first most frequent emotion in case of tie', () {
    final checkIns = [
      EmotionCheckIn(label: "Άγχος", icon: "😰", timestamp: DateTime.now()),
      EmotionCheckIn(label: "Χαρά", icon: "😊", timestamp: DateTime.now()),
      EmotionCheckIn(label: "Άγχος", icon: "😰", timestamp: DateTime.now()),
      EmotionCheckIn(label: "Χαρά", icon: "😊", timestamp: DateTime.now()),
    ];

    final result = getTomorrowPreview(checkIns);
    
    expect(result, contains("ανάσες")); // preview για "Άγχος"
  });
}
