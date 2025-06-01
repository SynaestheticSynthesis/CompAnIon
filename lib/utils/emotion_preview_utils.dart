import 'package:flutter_test/flutter_test.dart';
import '../lib/emotion_preview_utils.dart'; // Διόρθωσε το path αν χρειάζεται
import '../lib/emotion_check_in.dart'; // Αν το έχεις ξεχωριστά

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
