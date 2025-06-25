import 'package:companion_core/models/emotion_checkin_model.dart';

final List<EmotionCheckInModel> mockEmotionHistory = [
  EmotionCheckInModel(
    emotionLabel: 'Calm',
    emotionIcon: '🌿',
    timestamp: DateTime.now().subtract(Duration(hours: 2)),
    note: 'Ξεκίνησα τη μέρα με διαύγεια.',
  ),
  EmotionCheckInModel(
    emotionLabel: 'Overwhelmed',
    emotionIcon: '🌊',
    timestamp: DateTime.now().subtract(Duration(hours: 5)),
    note: 'Πολλά tasks στη δουλειά, νιώθω πίεση.',
  ),
  EmotionCheckInModel(
    emotionLabel: 'Grateful',
    emotionIcon: '🙏',
    timestamp: DateTime.now().subtract(Duration(days: 1, hours: 3)),
    note: 'Ένας φίλος με στήριξε απρόσμενα.',
  ),
  EmotionCheckInModel(
    emotionLabel: 'Lonely',
    emotionIcon: '🌑',
    timestamp: DateTime.now().subtract(Duration(days: 2)),
    note: 'Δεν ένιωθα κατανόηση από κανέναν.',
  ),
];
