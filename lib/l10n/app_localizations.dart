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

  /// No description provided for @menuPalliativeCare.
  ///
  /// In en, this message translates to:
  /// **'Palliative Care'**
  String get menuPalliativeCare;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @selectEmotion.
  ///
  /// In en, this message translates to:
  /// **'Select Emotion'**
  String get selectEmotion;

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
  /// **'Emotion History'**
  String get emotionHistory;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @exportHistoryCSV.
  ///
  /// In en, this message translates to:
  /// **'Export History (CSV)'**
  String get exportHistoryCSV;

  /// No description provided for @shareHistoryCSV.
  ///
  /// In en, this message translates to:
  /// **'Share History (CSV)'**
  String get shareHistoryCSV;

  /// No description provided for @previewCSV.
  ///
  /// In en, this message translates to:
  /// **'Preview CSV'**
  String get previewCSV;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

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

  /// No description provided for @feedbackHumanTouch.
  ///
  /// In en, this message translates to:
  /// **'Whatever you feel, I\'m here for you. Every emotion matters.'**
  String get feedbackHumanTouch;

  /// No description provided for @presenceMessageAfterReflection.
  ///
  /// In en, this message translates to:
  /// **'Thank you for sharing your reflection. It takes courage to look within. I\'m here, holding this space with you.'**
  String get presenceMessageAfterReflection;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to CompAnIon!'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'This is not just an app. It is a presence, a companion, a space for your truth. Take a breath and notice: you hold a tool for self-connection, not just productivity.'**
  String get onboardingWelcomeDesc;

  /// No description provided for @onboardingEmotionTitle.
  ///
  /// In en, this message translates to:
  /// **'Emotion Check-In'**
  String get onboardingEmotionTitle;

  /// No description provided for @onboardingEmotionDesc.
  ///
  /// In en, this message translates to:
  /// **'Here, you record how you feel. Pause, reflect, and let yourself be honest. Every emotion is valid. CompAnIon listens, never judges.'**
  String get onboardingEmotionDesc;

  /// No description provided for @onboardingReflectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Reflection Mode'**
  String get onboardingReflectionTitle;

  /// No description provided for @onboardingReflectionDesc.
  ///
  /// In en, this message translates to:
  /// **'After each check-in, you are invited to reflect. These questions are not tests—they are invitations to deeper understanding. Take your time.'**
  String get onboardingReflectionDesc;

  /// No description provided for @onboardingRememberTitle.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get onboardingRememberTitle;

  /// No description provided for @onboardingRememberDesc.
  ///
  /// In en, this message translates to:
  /// **'Honor loved ones, remember special dates, and keep memories alive. This is a space for tribute, gratitude, and gentle remembrance.'**
  String get onboardingRememberDesc;

  /// No description provided for @onboardingPalliativeTitle.
  ///
  /// In en, this message translates to:
  /// **'Palliative Care'**
  String get onboardingPalliativeTitle;

  /// No description provided for @onboardingPalliativeDesc.
  ///
  /// In en, this message translates to:
  /// **'Find support and resources for serious diagnoses and emotional needs. CompAnIon is here for every moment, including the difficult ones.'**
  String get onboardingPalliativeDesc;

  /// No description provided for @onboardingSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & Privacy'**
  String get onboardingSettingsTitle;

  /// No description provided for @onboardingSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'All data stays on your device. You choose your language, theme, and Care Mode. Privacy and dignity are at the heart of CompAnIon.'**
  String get onboardingSettingsDesc;

  /// No description provided for @onboardingFinalTitle.
  ///
  /// In en, this message translates to:
  /// **'A Final Thought'**
  String get onboardingFinalTitle;

  /// No description provided for @onboardingFinalDesc.
  ///
  /// In en, this message translates to:
  /// **'CompAnIon is built on empathy, presence, and respect. As you begin, ask yourself: “What do I need most right now?” This companion is here to help you remember, reflect, and feel less alone.'**
  String get onboardingFinalDesc;

  /// No description provided for @helpEmotionCheckIn.
  ///
  /// In en, this message translates to:
  /// **'This is your space to notice and record how you feel. Every emotion matters. CompAnIon is here to listen, not judge. Take a moment to reflect and honor your truth.'**
  String get helpEmotionCheckIn;

  /// No description provided for @helpRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Here you can honor loved ones, remember special dates, and keep memories alive. Tribute and gratitude are at the heart of this space.'**
  String get helpRememberMe;

  /// No description provided for @helpPalliativeCare.
  ///
  /// In en, this message translates to:
  /// **'Find support and resources for serious diagnoses and emotional needs. CompAnIon offers presence and care, even in difficult times.'**
  String get helpPalliativeCare;

  /// No description provided for @helpSettings.
  ///
  /// In en, this message translates to:
  /// **'Customize your experience: language, theme, font, and Care Mode. Privacy is sacred—your data stays on your device.'**
  String get helpSettings;

  /// No description provided for @helpDefault.
  ///
  /// In en, this message translates to:
  /// **'A mindful, emotionally intelligent companion. Here to help you reconnect with yourself.'**
  String get helpDefault;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About CompAnIon'**
  String get aboutTitle;

  /// No description provided for @manifestoTab.
  ///
  /// In en, this message translates to:
  /// **'Our Promise'**
  String get manifestoTab;

  /// No description provided for @ethicsTab.
  ///
  /// In en, this message translates to:
  /// **'Our Ethics'**
  String get ethicsTab;

  /// No description provided for @menuAbout.
  ///
  /// In en, this message translates to:
  /// **'About & Ethics'**
  String get menuAbout;

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

  /// No description provided for @infoTooltip.
  ///
  /// In en, this message translates to:
  /// **'What is this?'**
  String get infoTooltip;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

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

  /// No description provided for @noSpecialDatesToday.
  ///
  /// In en, this message translates to:
  /// **'No special dates today. A good day to be present.'**
  String get noSpecialDatesToday;

  /// No description provided for @allReminders.
  ///
  /// In en, this message translates to:
  /// **'All Reminders'**
  String get allReminders;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @reflection.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get reflection;

  /// No description provided for @emotion.
  ///
  /// In en, this message translates to:
  /// **'Emotion'**
  String get emotion;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @yourAnswer.
  ///
  /// In en, this message translates to:
  /// **'Your answer...'**
  String get yourAnswer;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @saveReflection.
  ///
  /// In en, this message translates to:
  /// **'Save Reflection'**
  String get saveReflection;

  /// No description provided for @fillAnswerToContinue.
  ///
  /// In en, this message translates to:
  /// **'Fill in the answer to continue'**
  String get fillAnswerToContinue;
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
