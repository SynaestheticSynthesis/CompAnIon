// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'CompAnIon';

  @override
  String get menuEmotionCheckIn => 'Καταγραφή Συναισθήματος';

  @override
  String get menuRememberMe => 'Remember Me';

  @override
  String get welcomeMessageEmpty => 'Καλώς ήρθες! Πώς νιώθεις αυτή τη στιγμή;';

  @override
  String get welcomeMessagePositive => 'Χαίρομαι που επιστρέφεις με θετική διάθεση! Πώς νιώθεις τώρα;';

  @override
  String get welcomeMessageNegative => 'Είμαι εδώ για σένα, ό,τι κι αν νιώθεις. Πώς είσαι σήμερα;';

  @override
  String get welcomeMessageNeutral => 'Παρατήρησε πώς νιώθεις αυτή τη στιγμή, χωρίς πίεση.';

  @override
  String get welcomeMessageMixed => 'Τα συναισθήματα αλλάζουν. Πώς είσαι τώρα;';

  @override
  String get recordEmotion => 'Καταγραφή Συναισθήματος';

  @override
  String get addCommentOptional => 'Πρόσθεσε σχόλιο (προαιρετικό)';

  @override
  String get emotionHistory => 'Ιστορικό Συναισθημάτων:';

  @override
  String get clearAll => 'Διαγραφή Όλων';

  @override
  String get exportHistoryCSV => 'Εξαγωγή ιστορικού (CSV)';

  @override
  String get shareHistoryCSV => 'Κοινή χρήση ιστορικού (CSV)';

  @override
  String get previewCSV => 'Προεπισκόπηση CSV';

  @override
  String get stats => 'Στατιστικά:';

  @override
  String get close => 'Κλείσιμο';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get cancel => 'Άκυρο';

  @override
  String get next => 'Επόμενο';

  @override
  String get previous => 'Προηγούμενο';

  @override
  String get reflectionSaved => 'Το reflection αποθηκεύτηκε!';

  @override
  String get noHistoryToExport => 'Δεν υπάρχει ιστορικό για εξαγωγή.';

  @override
  String get noHistoryToPreview => 'Δεν υπάρχει ιστορικό για προεπισκόπηση.';

  @override
  String filteredHistoryExported(Object filePath) {
    return 'Το φιλτραρισμένο ιστορικό εξήχθη στο: $filePath';
  }

  @override
  String errorExporting(Object error) {
    return 'Σφάλμα κατά την εξαγωγή: $error';
  }

  @override
  String get themeLight => 'Μετάβαση σε ανοιχτό θέμα';

  @override
  String get themeDark => 'Μετάβαση σε σκοτεινό θέμα';

  @override
  String get settings => 'Ρυθμίσεις';

  @override
  String get language => 'Γλώσσα';

  @override
  String get addReminder => 'Προσθήκη υπενθύμισης';

  @override
  String get inMemory => 'Στη μνήμη';

  @override
  String get specialDay => 'Ιδιαίτερη μέρα';

  @override
  String get call => 'Τηλέφωνο';

  @override
  String get write => 'Γράψε';

  @override
  String get lightCandle => 'Άναψε κερί';

  @override
  String get rememberSilently => 'Θυμήσου σιωπηλά';

  @override
  String get noSpecialDatesToday => 'Δεν υπάρχουν ιδιαίτερες ημερομηνίες σήμερα.\nΠρόσθεσε ένα αγαπημένο πρόσωπο για να το θυμάσαι.';

  @override
  String get allReminders => 'Όλες οι υπενθυμίσεις:';

  @override
  String get comment => 'Σχόλιο';

  @override
  String get emotion => 'Συναίσθημα';

  @override
  String get yourAnswer => 'Η απάντησή σου...';

  @override
  String get fillAnswerToContinue => 'Συμπλήρωσε την απάντηση για να συνεχίσεις.';

  @override
  String get saveReflection => 'Αποθήκευση Reflection';

  @override
  String get reflection => 'Στοχασμός';
}
