import '../emotion_hierarchy.dart';
import '../logic/context_signals.dart';

String synthesizeGuidance(String emotion) {
  final category = classifyEmotion(emotion);
  final time = ContextSignals.getTimeOfDay();
  final location = ContextSignals.getLocation();
  final weather = ContextSignals.getWeather();

  // Synaesthetic synthesis: blend emotion, time, place, and weather into a message
  if (category == 'positive') {
    return "In this $weather $time at $location, your $emotion shines. Let it ripple outward.";
  } else if (category == 'negative') {
    return "It's $time and $weather at $location. Your $emotion is valid—breathe, and let presence hold you gently.";
  } else if (category == 'neutral') {
    return "A $weather $time at $location. Sometimes, neutrality is the space where new colors are born.";
  } else {
    return "Here, now, in the $weather $time at $location, your feelings are a unique blend. Notice their texture—no need to judge.";
  }
}
