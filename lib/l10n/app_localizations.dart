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
