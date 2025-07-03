import 'package:companion_core/data/app_database.dart';
import 'package:companion_core/models/emotion_checkin.dart';



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






