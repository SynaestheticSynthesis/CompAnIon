import 'package:companion_core/data/app_database.dart';

final List<EmotionCheckIn> mockEmotionHistory = [
  EmotionCheckIn(
    emotion: 'Calm',
    emoji: '🌿',
    text: 'Ξεκίνησα τη μέρα με διαύγεια.',
    timestamp: DateTime.now().subtract(Duration(hours: 2)),
  ),
  EmotionCheckIn(
    emotion: 'Overwhelmed',
    emoji: '🌊',
    text: 'Πολλά tasks στη δουλειά, νιώθω πίεση.',
    timestamp: DateTime.now().subtract(Duration(hours: 5)),
  ), 
  EmotionCheckIn(
    emotion: 'Happy',
    emoji: '😊',
    text: 'Είχα μια όμορφη συζήτηση με φίλους.',
    timestamp: DateTime.now().subtract(Duration(days: 1)),
  ),
  EmotionCheckIn(
    emotion: 'Sad',
    emoji: '😢',
    text: 'Ένιωσα λύπη για ένα παλιό γεγονός.',
    timestamp: DateTime.now().subtract(Duration(days: 2)),
  ),  
  EmotionCheckIn(
    emotion: 'Anxious',
    emoji: '😰',
    text: 'Ανησυχώ για τις επόμενες μέρες.',
    timestamp: DateTime.now().subtract(Duration(days: 3)),
  ),
  EmotionCheckIn(
    emotion: 'Excited',
    emoji: '🎉',
    text: 'Περιμένω ένα σημαντικό γεγονός.',
    timestamp: DateTime.now().subtract(Duration(days: 4)),
  ),
  EmotionCheckIn(
    emotion: 'Lonely',
    emoji: '😔',
    text: 'Νιώθω μοναξιά αυτές τις μέρες.',
    timestamp: DateTime.now().subtract(Duration(days: 5)),
  ),
  EmotionCheckIn(
    emotion: 'Grateful',
    emoji: '🙏',
    text: 'Ευγνώμον για την υποστήριξη των φίλων μου.',
    timestamp: DateTime.now().subtract(Duration(days: 6)),
  ),
  EmotionCheckIn(
    emotion: 'Frustrated',
    emoji: '😠',
    text: 'Απογοητεύτηκα από μια κατάσταση στη δουλειά.',
    timestamp: DateTime.now().subtract(Duration(days: 7)),
  ), 
  EmotionCheckIn(
    emotion: 'Hopeful',
    emoji: '🌈',
    text: 'Ελπίζω για καλύτερες μέρες.',
    timestamp: DateTime.now().subtract(Duration(days: 8)),
  ),
  EmotionCheckIn(
    emotion: 'Confused',
    emoji: '🤔',
    text: 'Δεν ξέρω πώς να χειριστώ μια κατάσταση.',
    timestamp: DateTime.now().subtract(Duration(days: 9)),
  ),
  EmotionCheckIn(
    emotion: 'Inspired',
    emoji: '💡',
    text: 'Έχω νέες ιδέες για το μέλλον.',
    timestamp: DateTime.now().subtract(Duration(days: 10)),
  ),
  EmotionCheckIn(
    emotion: 'Tired',
    emoji: '😴',
    text: 'Νιώθω κουρασμένος μετά από μια δύσκολη εβδομάδα.',
    timestamp: DateTime.now().subtract(Duration(days: 11)),
  ),
  EmotionCheckIn(
    emotion: 'Motivated',
    emoji: '🚀',
    text: 'Έχω κίνητρο να πετύχω τους στόχους μου.',
    timestamp: DateTime.now().subtract(Duration(days: 12)),
  ),
  EmotionCheckIn(
    emotion: 'Bored',
    emoji: '😒',
    text: 'Δεν έχω τι να κάνω σήμερα.',
    timestamp: DateTime.now().subtract(Duration(days: 13)),
  ),
  EmotionCheckIn(
    emotion: 'Relieved',
    emoji: '😌',
    text: 'Ανακουφίστηκα από μια ανησυχία.',
    timestamp: DateTime.now().subtract(Duration(days: 14)),
  ),
  EmotionCheckIn(
    emotion: 'Curious',
    emoji: '🤗',
    text: 'Θέλω να μάθω περισσότερα για τον κόσμο γύρω μου.',
    timestamp: DateTime.now().subtract(Duration(days: 15)),
  ),
  EmotionCheckIn(
    emotion: 'Proud',
    emoji: '🏆',
    text: 'Είμαι περήφανος για τις επιτυχίες μου.',
    timestamp: DateTime.now().subtract(Duration(days: 16)),
  ),
  EmotionCheckIn(
    emotion: 'Nostalgic',
    emoji: '🌅',
    text: 'Σκέφτομαι παλιές καλές στιγμές.',
    timestamp: DateTime.now().subtract(Duration(days: 17)),
  ),
  EmotionCheckIn(
    emotion: 'Disappointed',
    emoji: '😞',
    text: 'Απογοητεύτηκα από μια κατάσταση.',
    timestamp: DateTime.now().subtract(Duration(days: 18)),
  ),
  EmotionCheckIn(
    emotion: 'Content',
    emoji: '😊',
    text: 'Είμαι ευχαριστημένος με τη ζωή μου αυτή τη στιγμή.',
    timestamp: DateTime.now().subtract(Duration(days: 19)),
  ),
  EmotionCheckIn(
    emotion: 'Empowered',
    emoji: '💪',
    text: 'Νιώθω δυνατός και ικανός να αντιμετωπίσω προκλήσεις.',
    timestamp: DateTime.now().subtract(Duration(days: 20)),
  ),
  EmotionCheckIn(
    emotion: 'Stressed',
    emoji: '😫',
    text: 'Έχω πολλή πίεση στη δουλειά και στο σπίτι.',
    timestamp: DateTime.now().subtract(Duration(days: 21)),
  ),
  EmotionCheckIn(
    emotion: 'Relaxed',
    emoji: '🧘',
    text: 'Πέρασα χρόνο χαλαρώνοντας και απολαμβάνοντας τη φύση.',
    timestamp: DateTime.now().subtract(Duration(days: 22)),
  ),
  EmotionCheckIn(
    emotion: 'Confident',
    emoji: '😎',
    text: 'Νιώθω αυτοπεποίθηση για τις ικανότητές μου.',
    timestamp: DateTime.now().subtract(Duration(days: 23)),
  ),
  EmotionCheckIn(
    emotion: 'Disgusted',
    emoji: '🤢',
    text: 'Ένιωσα αηδία για κάτι που είδα.',
    timestamp: DateTime.now().subtract(Duration(days: 24)),
  ),
  EmotionCheckIn(
    emotion: 'Surprised',
    emoji: '😲',
    text: 'Έπαθα έκπληξη με μια ευχάριστη είδηση.',
    timestamp: DateTime.now().subtract(Duration(days: 25)),
  ),
  EmotionCheckIn(
    emotion: 'Jealous',
    emoji: '😒',
    text: 'Ένιωσα ζήλια για την επιτυχία ενός φίλου.',
    timestamp: DateTime.now().subtract(Duration(days: 26)),
  ),
  EmotionCheckIn(
    emotion: 'Hopeful',
    emoji: '🌈',
    text: 'Ελπίζω για ένα καλύτερο μέλλον.',
    timestamp: DateTime.now().subtract(Duration(days: 27)),
  ),
  EmotionCheckIn(
    emotion: 'Inspired',
    emoji: '💡',
    text: 'Έχω νέες ιδέες και όραμα για το μέλλον.',
    timestamp: DateTime.now().subtract(Duration(days: 28)),
  ),
  EmotionCheckIn(
    emotion: 'Grateful',
    emoji: '🙏',
    text: 'Ευγνώμον για την υποστήριξη των φίλων μου.',
    timestamp: DateTime.now().subtract(Duration(days: 29)),
  ),
  EmotionCheckIn(
    emotion: 'Frustrated',
    emoji: '😠',
    text: 'Απογοητεύτηκα από μια κατάσταση στη δουλειά.',
    timestamp: DateTime.now().subtract(Duration(days: 30)),
  ),
  EmotionCheckIn(
    emotion: 'Hopeful',
    emoji: '🌈',
    text: 'Ελπίζω για καλύτερες μέρες.',
    timestamp: DateTime.now().subtract(Duration(days: 31)),
  ),
  EmotionCheckIn(
    emotion: 'Confused',
    emoji: '🤔',
    text: 'Δεν ξέρω πώς να χειριστώ μια κατάσταση.',
    timestamp: DateTime.now().subtract(Duration(days: 32)),
  ),
  EmotionCheckIn(
    emotion: 'Joy',
    emoji: '😊',
    timestamp: DateTime.now(),
    text: 'Felt good today'
  ),
];

  List<EmotionCheckIn> getMockEmotionHistory() {
  return List.from(mockEmotionHistory);
}
EmotionCheckIn? getLatestEmotionCheckIn() {
  if (mockEmotionHistory.isEmpty) return null;
  return mockEmotionHistory.reduce((a, b) => a.timestamp.isAfter(b.timestamp) ? a : b);
}
EmotionCheckIn? getFirstEmotionCheckIn() {
  if (mockEmotionHistory.isEmpty) return null;
  return mockEmotionHistory.reduce((a, b) => a.timestamp.isBefore(b.timestamp) ? a : b);
} 
List<EmotionCheckIn> getLastNDaysEmotionHistory(int n) {
  final now = DateTime.now();
  return mockEmotionHistory.where((checkIn) {
    final diff = now.difference(checkIn.timestamp);
    return diff.inDays < n;
  }).toList();
}
List<EmotionCheckIn> getLastNWeeksEmotionHistory(int n) {
  final now = DateTime.now();
  return mockEmotionHistory.where((checkIn) {
    final diff = now.difference(checkIn.timestamp);
    return diff.inDays < n * 7;
  }).toList();
}
List<EmotionCheckIn> getLastNMonthsEmotionHistory(int n) {
  final now = DateTime.now();
  return mockEmotionHistory.where((checkIn) {
    final diff = now.difference(checkIn.timestamp);
    return diff.inDays < n * 30; // Approximation of a month
  }).toList();
}
  List<EmotionCheckIn> getLastNYearsEmotionHistory(int n) {
  final now = DateTime.now();
  return mockEmotionHistory.where((checkIn) {
    final diff = now.difference(checkIn.timestamp);
    return diff.inDays < n * 365; // Approximation of a year
  }).toList();
}
List<EmotionCheckIn> getLastNEmotions(int n) {
  return mockEmotionHistory.take(n).toList();
}
List<EmotionCheckIn> getEmotionsByLabel(String label) {
  return mockEmotionHistory.where((checkIn) => checkIn.emotion == label).toList();
}

List<EmotionCheckIn> getEmotionsByDate(DateTime date) {
  return mockEmotionHistory.where((checkIn) {
    final checkInDate = DateTime(checkIn.timestamp.year, checkIn.timestamp.month, checkIn.timestamp.day);
    return checkInDate == date;
  }).toList();
}
List<EmotionCheckIn> getEmotionsByDateRange(DateTime start, DateTime end) {
  return mockEmotionHistory.where((checkIn) {
    final checkInDate = DateTime(checkIn.timestamp.year, checkIn.timestamp.month, checkIn.timestamp.day);
    return checkInDate.isAfter(start) && checkInDate.isBefore(end);
  }).toList();
}
List<EmotionCheckIn> getEmotionsByEmoji(String emoji) {
  return mockEmotionHistory.where((checkIn) => checkIn.emoji == emoji).toList();
  }
  List<EmotionCheckIn> getEmotionsByText(String text) {

  return mockEmotionHistory.where((checkIn) => checkIn.text != null && checkIn.text!.contains(text)).toList();
  } 
  List<EmotionCheckIn> getEmotionsByTimestamp(DateTime timestamp) {
  return mockEmotionHistory.where((checkIn) => checkIn.timestamp == timestamp).toList();
  }
List<EmotionCheckIn> getEmotionsByTimestampRange(DateTime start, DateTime end) {
  return mockEmotionHistory.where((checkIn) {
    return checkIn.timestamp.isAfter(start) && checkIn.timestamp.isBefore(end);
  }).toList();  
}

// When accessing fields elsewhere, always check for null:
String getEmojiSafe(EmotionCheckIn checkIn) => checkIn.emoji ?? '🙂';
String getTextSafe(EmotionCheckIn checkIn) => checkIn.text ?? '';






