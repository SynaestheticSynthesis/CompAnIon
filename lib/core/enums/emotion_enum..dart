// lib/core/enums/emotion_enum.dart

enum Emotion {
  joy,
  sadness,
  anger,
  fear,
  surprise,
  love,
  confusion,
  loneliness,
  anxiety,
  calm,
  gratitude,
  tired,
  overwhelmed,
  neutral, // fallback or baseline
}

// Optional helper extension
extension EmotionExtension on Emotion {
  String get name {
    switch (this) {
      case Emotion.joy:
        return "Joy";
      case Emotion.sadness:
        return "Sadness";
      case Emotion.anger:
        return "Anger";
      case Emotion.fear:
        return "Fear";
      case Emotion.surprise:
        return "Surprise";
      case Emotion.love:
        return "Love";
      case Emotion.confusion:
        return "Confusion";
      case Emotion.loneliness:
        return "Loneliness";
      case Emotion.anxiety:
        return "Anxiety";
      case Emotion.calm:
        return "Calm";
      case Emotion.gratitude:
        return "Gratitude";
      case Emotion.tired:
        return "Tired";
      case Emotion.overwhelmed:
        return "Overwhelmed";
      case Emotion.neutral:
        return "Neutral";
    }
  }
}
// This enum can be used to represent various emotional states in the application.
// It can be extended with methods or properties to provide additional functionality, 
// such as localized names or descriptions for each emotion.
// The `EmotionExtension` provides a way to get the name of each emotion in a more readable format.
// This can be useful for displaying emotions in the UI or logging them in a user-friendly way.
// The enum can be used in various parts of the application, such as:     
  // - Tracking user emotional states
  // - Providing feedback based on emotional analysis
  // - Integrating with machine learning models for emotion detection 
  // - Enhancing user experience by adapting responses based on detected emotions
  // - Logging and debugging emotional states during development
  //       logs.add('Σφάλμα: ${e.toString()}')
  