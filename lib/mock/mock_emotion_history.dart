import 'package:companion_core/models/emotion_checkin.dart';

final List<EmotionCheckIn> mockEmotionHistory = [
  EmotionCheckIn(
    emotion: 'Calm',
    emoji: '🌿',
    text: 'Ξεκίνησα τη μέρα με διαύγεια.',
    emotionLabel: 'Calm',
    emotionIcon: '🌿',
    timestamp: DateTime.now().subtract(Duration(hours: 2)),
    note: 'Ξεκίνησα τη μέρα με διαύγεια.',
  ),
  EmotionCheckIn(
    emotion: 'Overwhelmed',
    emoji: '🌊',
    text: 'Πολλά tasks στη δουλειά, νιώθω πίεση.',
    emotionLabel: 'Overwhelmed',
    emotionIcon: '🌊',
    timestamp: DateTime.now().subtract(Duration(hours: 5)),
    note: 'Πολλά tasks στη δουλειά, νιώθω πίεση.',
  ),
  