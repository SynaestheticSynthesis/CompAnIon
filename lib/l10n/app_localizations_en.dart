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
}
