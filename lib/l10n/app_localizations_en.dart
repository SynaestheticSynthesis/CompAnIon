// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CompAnIon';

  @override
  String get menuEmotionCheckIn => 'Emotion Check-In';

  @override
  String get menuRememberMe => 'Remember Me';

  @override
  String get welcomeMessageEmpty => 'Welcome! How are you feeling right now?';

  @override
  String get welcomeMessagePositive => 'Glad to see you back in a positive mood! How do you feel now?';

  @override
  String get welcomeMessageNegative => 'I\'m here for you, whatever you feel. How are you today?';

  @override
  String get welcomeMessageNeutral => 'Notice how you feel right now, no pressure.';

  @override
  String get welcomeMessageMixed => 'Feelings change. How are you now?';

  @override
  String get recordEmotion => 'Record Emotion';

  @override
  String get addCommentOptional => 'Add a comment (optional)';

  @override
  String get emotionHistory => 'Emotion History:';

  @override
  String get clearAll => 'Clear All';

  @override
  String get exportHistoryCSV => 'Export history (CSV)';

  @override
  String get shareHistoryCSV => 'Share history (CSV)';

  @override
  String get previewCSV => 'Preview CSV';

  @override
  String get stats => 'Stats:';

  @override
  String get close => 'Close';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Previous';

  @override
  String get reflectionSaved => 'Reflection saved!';

  @override
  String get noHistoryToExport => 'No history to export.';

  @override
  String get noHistoryToPreview => 'No history to preview.';

  @override
  String filteredHistoryExported(Object filePath) {
    return 'Filtered history exported to: $filePath';
  }

  @override
  String errorExporting(Object error) {
    return 'Error exporting: $error';
  }

  @override
  String get themeLight => 'Switch to Light Theme';

  @override
  String get themeDark => 'Switch to Dark Theme';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get addReminder => 'Add Reminder';

  @override
  String get inMemory => 'In Memory';

  @override
  String get specialDay => 'Special Day';

  @override
  String get call => 'Call';

  @override
  String get write => 'Write';

  @override
  String get lightCandle => 'Light a candle';

  @override
  String get rememberSilently => 'Remember silently';

  @override
  String get noSpecialDatesToday => 'No special dates today.\nAdd a loved one to remember.';

  @override
  String get allReminders => 'All Reminders:';

  @override
  String get comment => 'Comment';

  @override
  String get emotion => 'Emotion';

  @override
  String get yourAnswer => 'Your answer...';

  @override
  String get fillAnswerToContinue => 'Please fill in your answer to continue.';

  @override
  String get saveReflection => 'Save Reflection';

  @override
  String get reflection => 'Reflection';

  @override
  String get happy => 'Happy';

  @override
  String get sad => 'Sad';

  @override
  String get angry => 'Angry';

  @override
  String get anxious => 'Anxious';

  @override
  String get neutral => 'Neutral';

  @override
  String get excited => 'Excited';

  @override
  String get disappointed => 'Disappointed';

  @override
  String get contextPrompt => 'How are you feeling right now?';

  @override
  String get contextPromptMorning => 'Good morning! How do you feel as you start your day?';

  @override
  String get contextPromptEvening => 'Evenings are for reflection. How are you feeling tonight?';

  @override
  String get atWork => 'At work';

  @override
  String get atHome => 'At home';

  @override
  String get weatherRainy => 'It\'s rainy outside. Does the weather affect your mood?';

  @override
  String get greetingMorning => '🌅 Good morning, friend!';

  @override
  String get greetingAfternoon => '🌞 Good afternoon, friend!';

  @override
  String get greetingEvening => '🌙 Good evening, friend!';

  @override
  String get greetingNight => '🌌 Night is here. How are you?';

  @override
  String get greetingDefault => 'Hello, friend!';

  @override
  String get selectEmotion => 'Select emotion';

  @override
  String get searchReminders => 'Search reminders';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get inMemoryEmoji => '🙏';

  @override
  String get font => 'Font';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontRoboto => 'Roboto';

  @override
  String get fontOpenSans => 'Open Sans';

  @override
  String get theme => 'Theme';

  @override
  String get gender => 'Gender';

  @override
  String get genderNeutral => 'Neutral';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderMale => 'Male';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageGreek => 'Greek';

  @override
  String get importReminders => 'Import Reminders';

  @override
  String get feedbackMorning => 'The start of the day is a chance for new energy.';

  @override
  String get feedbackRainy => 'Rain brings renewal. How do you feel about the weather today?';

  @override
  String get feedbackStreakPositive => 'I see you often feel happy. What helps you keep this mood?';

  @override
  String get feedbackStreakNegative => 'You\'ve felt sad several times. Would you like to share what\'s on your mind or try something new?';

  @override
  String get feedbackStreakAngry => 'Anger is normal. Maybe a walk or a deep breath could help?';

  @override
  String get feedbackStreakAnxious => 'Anxiety appears often. Would you like to try a relaxation technique?';

  @override
  String get feedbackRecentChange => 'I notice a change in your feelings. Would you like to share what happened?';

  @override
  String get feedbackEveningSad => 'Evenings are hard for many. Maybe writing a few words or talking to someone could help?';

  @override
  String get feedbackSunnyNeutral => 'The sun outside might bring a small change in mood. Want to go out for a bit?';

  @override
  String get feedbackPattern => 'There\'s a pattern in your feelings. Maybe it\'s time for a small change?';

  @override
  String get feedbackHumanTouch => 'Whatever you feel, I\'m here for you. Every emotion matters.';
}
