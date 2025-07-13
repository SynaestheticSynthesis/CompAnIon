import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_el.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('el'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'CompAnIon'**
  String get appTitle;

  /// No description provided for @menuEmotionCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Emotion Check-In'**
  String get menuEmotionCheckIn;

  /// No description provided for @menuRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get menuRememberMe;

  /// No description provided for @welcomeMessageEmpty.
  ///
  /// In en, this message translates to:
  /// **'Welcome! How are you feeling right now?'**
  String get welcomeMessageEmpty;

  /// No description provided for @welcomeMessagePositive.
  ///
  /// In en, this message translates to:
  /// **'Glad to see you back in a positive mood! How do you feel now?'**
  String get welcomeMessagePositive;

  /// No description provided for @welcomeMessageNegative.
  ///
  /// In en, this message translates to:
  /// **'I\'m here for you, whatever you feel. How are you today?'**
  String get welcomeMessageNegative;

  /// No description provided for @welcomeMessageNeutral.
  ///
  /// In en, this message translates to:
  /// **'Notice how you feel right now, no pressure.'**
  String get welcomeMessageNeutral;

  /// No description provided for @welcomeMessageMixed.
  ///
  /// In en, this message translates to:
  /// **'Feelings change. How are you now?'**
  String get welcomeMessageMixed;

  /// No description provided for @recordEmotion.
  ///
  /// In en, this message translates to:
  /// **'Record Emotion'**
  String get recordEmotion;

  /// No description provided for @addCommentOptional.
  ///
  /// In en, this message translates to:
  /// **'Add a comment (optional)'**
  String get addCommentOptional;

  /// No description provided for @emotionHistory.
  ///
  /// In en, this message translates to:
  /// **'Emotion History:'**
  String get emotionHistory;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @exportHistoryCSV.
  ///
  /// In en, this message translates to:
  /// **'Export history (CSV)'**
  String get exportHistoryCSV;

  /// No description provided for @shareHistoryCSV.
  ///
  /// In en, this message translates to:
  /// **'Share history (CSV)'**
  String get shareHistoryCSV;

  /// No description provided for @previewCSV.
  ///
  /// In en, this message translates to:
  /// **'Preview CSV'**
  String get previewCSV;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats:'**
  String get stats;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @reflectionSaved.
  ///
  /// In en, this message translates to:
  /// **'Reflection saved!'**
  String get reflectionSaved;

  /// No description provided for @noHistoryToExport.
  ///
  /// In en, this message translates to:
  /// **'No history to export.'**
  String get noHistoryToExport;

  /// No description provided for @noHistoryToPreview.
  ///
  /// In en, this message translates to:
  /// **'No history to preview.'**
  String get noHistoryToPreview;

  /// No description provided for @filteredHistoryExported.
  ///
  /// In en, this message translates to:
  /// **'Filtered history exported to: {filePath}'**
  String filteredHistoryExported(Object filePath);

  /// No description provided for @errorExporting.
  ///
  /// In en, this message translates to:
  /// **'Error exporting: {error}'**
  String errorExporting(Object error);

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Switch to Light Theme'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Switch to Dark Theme'**
  String get themeDark;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @addReminder.
  ///
  /// In en, this message translates to:
  /// **'Add Reminder'**
  String get addReminder;

  /// No description provided for @inMemory.
  ///
  /// In en, this message translates to:
  /// **'In Memory'**
  String get inMemory;

  /// No description provided for @specialDay.
  ///
  /// In en, this message translates to:
  /// **'Special Day'**
  String get specialDay;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @write.
  ///
  /// In en, this message translates to:
  /// **'Write'**
  String get write;

  /// No description provided for @lightCandle.
  ///
  /// In en, this message translates to:
  /// **'Light a candle'**
  String get lightCandle;

  /// No description provided for @rememberSilently.
  ///
  /// In en, this message translates to:
  /// **'Remember silently'**
  String get rememberSilently;

  /// No description provided for @noSpecialDatesToday.
  ///
  /// In en, this message translates to:
  /// **'No special dates today.\nAdd a loved one to remember.'**
  String get noSpecialDatesToday;

  /// No description provided for @allReminders.
  ///
  /// In en, this message translates to:
  /// **'All Reminders:'**
  String get allReminders;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @emotion.
  ///
  /// In en, this message translates to:
  /// **'Emotion'**
  String get emotion;

  /// No description provided for @yourAnswer.
  ///
  /// In en, this message translates to:
  /// **'Your answer...'**
  String get yourAnswer;

  /// No description provided for @fillAnswerToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please fill in your answer to continue.'**
  String get fillAnswerToContinue;

  /// No description provided for @saveReflection.
  ///
  /// In en, this message translates to:
  /// **'Save Reflection'**
  String get saveReflection;

  /// No description provided for @reflection.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get reflection;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// No description provided for @sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// No description provided for @angry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get angry;

  /// No description provided for @anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get anxious;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutral;

  /// No description provided for @excited.
  ///
  /// In en, this message translates to:
  /// **'Excited'**
  String get excited;

  /// No description provided for @disappointed.
  ///
  /// In en, this message translates to:
  /// **'Disappointed'**
  String get disappointed;

  /// No description provided for @contextPrompt.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling right now?'**
  String get contextPrompt;

  /// No description provided for @contextPromptMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning! How do you feel as you start your day?'**
  String get contextPromptMorning;

  /// No description provided for @contextPromptEvening.
  ///
  /// In en, this message translates to:
  /// **'Evenings are for reflection. How are you feeling tonight?'**
  String get contextPromptEvening;

  /// No description provided for @atWork.
  ///
  /// In en, this message translates to:
  /// **'At work'**
  String get atWork;

  /// No description provided for @atHome.
  ///
  /// In en, this message translates to:
  /// **'At home'**
  String get atHome;

  /// No description provided for @weatherRainy.
  ///
  /// In en, this message translates to:
  /// **'It\'s rainy outside. Does the weather affect your mood?'**
  String get weatherRainy;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'🌅 Good morning, friend!'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'🌞 Good afternoon, friend!'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'🌙 Good evening, friend!'**
  String get greetingEvening;

  /// No description provided for @greetingNight.
  ///
  /// In en, this message translates to:
  /// **'🌌 Night is here. How are you?'**
  String get greetingNight;

  /// No description provided for @greetingDefault.
  ///
  /// In en, this message translates to:
  /// **'Hello, friend!'**
  String get greetingDefault;

  /// No description provided for @selectEmotion.
  ///
  /// In en, this message translates to:
  /// **'Select emotion'**
  String get selectEmotion;

  /// No description provided for @searchReminders.
  ///
  /// In en, this message translates to:
  /// **'Search reminders'**
  String get searchReminders;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @inMemoryEmoji.
  ///
  /// In en, this message translates to:
  /// **'🙏'**
  String get inMemoryEmoji;

  /// No description provided for @font.
  ///
  /// In en, this message translates to:
  /// **'Font'**
  String get font;

  /// No description provided for @fontNunito.
  ///
  /// In en, this message translates to:
  /// **'Nunito'**
  String get fontNunito;

  /// No description provided for @fontRoboto.
  ///
  /// In en, this message translates to:
  /// **'Roboto'**
  String get fontRoboto;

  /// No description provided for @fontOpenSans.
  ///
  /// In en, this message translates to:
  /// **'Open Sans'**
  String get fontOpenSans;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @genderNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get genderNeutral;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageGreek.
  ///
  /// In en, this message translates to:
  /// **'Greek'**
  String get languageGreek;

  /// No description provided for @importReminders.
  ///
  /// In en, this message translates to:
  /// **'Import Reminders'**
  String get importReminders;

  /// No description provided for @feedbackMorning.
  ///
  /// In en, this message translates to:
  /// **'The start of the day is a chance for new energy.'**
  String get feedbackMorning;

  /// No description provided for @feedbackRainy.
  ///
  /// In en, this message translates to:
  /// **'Rain brings renewal. How do you feel about the weather today?'**
  String get feedbackRainy;

  /// No description provided for @feedbackStreakPositive.
  ///
  /// In en, this message translates to:
  /// **'I see you often feel happy. What helps you keep this mood?'**
  String get feedbackStreakPositive;

  /// No description provided for @feedbackStreakNegative.
  ///
  /// In en, this message translates to:
  /// **'You\'ve felt sad several times. Would you like to share what\'s on your mind or try something new?'**
  String get feedbackStreakNegative;

  /// No description provided for @feedbackStreakAngry.
  ///
  /// In en, this message translates to:
  /// **'Anger is normal. Maybe a walk or a deep breath could help?'**
  String get feedbackStreakAngry;

  /// No description provided for @feedbackStreakAnxious.
  ///
  /// In en, this message translates to:
  /// **'Anxiety appears often. Would you like to try a relaxation technique?'**
  String get feedbackStreakAnxious;

  /// No description provided for @feedbackRecentChange.
  ///
  /// In en, this message translates to:
  /// **'I notice a change in your feelings. Would you like to share what happened?'**
  String get feedbackRecentChange;

  /// No description provided for @feedbackEveningSad.
  ///
  /// In en, this message translates to:
  /// **'Evenings are hard for many. Maybe writing a few words or talking to someone could help?'**
  String get feedbackEveningSad;

  /// No description provided for @feedbackSunnyNeutral.
  ///
  /// In en, this message translates to:
  /// **'The sun outside might bring a small change in mood. Want to go out for a bit?'**
  String get feedbackSunnyNeutral;

  /// No description provided for @feedbackPattern.
  ///
  /// In en, this message translates to:
  /// **'There\'s a pattern in your feelings. Maybe it\'s time for a small change?'**
  String get feedbackPattern;

  /// No description provided for @feedbackHumanTouch.
  ///
  /// In en, this message translates to:
  /// **'Whatever you feel, I\'m here for you. Every emotion matters.'**
  String get feedbackHumanTouch;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['el', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'el': return AppLocalizationsEl();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
