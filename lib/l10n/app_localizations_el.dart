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
  String get menuPalliativeCare => 'Ανακουφιστική Φροντίδα';

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

  @override
  String get happy => 'Χαρούμενος';

  @override
  String get sad => 'Λυπημένος';

  @override
  String get angry => 'Θυμωμένος';

  @override
  String get anxious => 'Αγχωμένος';

  @override
  String get neutral => 'Ουδέτερος';

  @override
  String get excited => 'Ενθουσιασμένος';

  @override
  String get disappointed => 'Απογοητευμένος';

  @override
  String get contextPrompt => 'Πώς νιώθεις αυτή τη στιγμή;';

  @override
  String get contextPromptMorning => 'Καλημέρα! Πώς νιώθεις ξεκινώντας τη μέρα;';

  @override
  String get contextPromptEvening => 'Τα βράδια είναι για στοχασμό. Πώς νιώθεις απόψε;';

  @override
  String get atWork => 'Στη δουλειά';

  @override
  String get atHome => 'Στο σπίτι';

  @override
  String get weatherRainy => 'Βρέχει έξω. Σε επηρεάζει ο καιρός;';

  @override
  String get greetingMorning => '🌅 Καλημέρα, φίλε!';

  @override
  String get greetingAfternoon => '🌞 Καλό απόγευμα, φίλε!';

  @override
  String get greetingEvening => '🌙 Καλό βράδυ, φίλε!';

  @override
  String get greetingNight => '🌌 Η νύχτα ήρθε. Πώς είσαι;';

  @override
  String get greetingDefault => 'Γεια σου, φίλε!';

  @override
  String get selectEmotion => 'Επιλογή συναισθήματος';

  @override
  String get searchReminders => 'Αναζήτηση υπενθυμίσεων';

  @override
  String get edit => 'Επεξεργασία';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get inMemoryEmoji => '🙏';

  @override
  String get font => 'Γραμματοσειρά';

  @override
  String get fontNunito => 'Nunito';

  @override
  String get fontRoboto => 'Roboto';

  @override
  String get fontOpenSans => 'Open Sans';

  @override
  String get theme => 'Θέμα';

  @override
  String get gender => 'Φύλο';

  @override
  String get genderNeutral => 'Ουδέτερο';

  @override
  String get genderFemale => 'Θηλυκό';

  @override
  String get genderMale => 'Αρσενικό';

  @override
  String get languageEnglish => 'Αγγλικά';

  @override
  String get languageGreek => 'Ελληνικά';

  @override
  String get importReminders => 'Εισαγωγή υπενθυμίσεων';

  @override
  String get feedbackMorning => 'Η αρχή της μέρας είναι ευκαιρία για νέα ενέργεια.';

  @override
  String get feedbackRainy => 'Η βροχή φέρνει ανανέωση. Πώς νιώθεις με τον καιρό σήμερα;';

  @override
  String get feedbackStreakPositive => 'Βλέπω ότι νιώθεις συχνά χαρούμενος/η. Τι σε βοηθά να διατηρείς αυτή τη διάθεση;';

  @override
  String get feedbackStreakNegative => 'Έχεις νιώσει λυπημένος/η αρκετές φορές. Θέλεις να μοιραστείς τι σε απασχολεί ή να δοκιμάσεις κάτι νέο;';

  @override
  String get feedbackStreakAngry => 'Ο θυμός είναι φυσιολογικός. Μήπως μια μικρή βόλτα ή βαθιά ανάσα βοηθήσει;';

  @override
  String get feedbackStreakAnxious => 'Το άγχος εμφανίζεται συχνά. Θέλεις να δοκιμάσεις μια τεχνική χαλάρωσης;';

  @override
  String get feedbackRecentChange => 'Παρατηρώ μια αλλαγή στα συναισθήματά σου. Θέλεις να μοιραστείς τι συνέβη;';

  @override
  String get feedbackEveningSad => 'Τα βράδια είναι δύσκολα για πολλούς. Μήπως βοηθά να γράψεις λίγα λόγια ή να μιλήσεις σε κάποιον;';

  @override
  String get feedbackSunnyNeutral => 'Ο ήλιος έξω μπορεί να φέρει μια μικρή αλλαγή στη διάθεση. Θέλεις να βγεις για λίγο;';

  @override
  String get feedbackPattern => 'Παρατηρείται μοτίβο στα συναισθήματά σου. Μήπως ήρθε η ώρα για μια μικρή αλλαγή;';

  @override
  String get feedbackHumanTouch => 'Ό,τι κι αν νιώθεις, είμαι εδώ για σένα. Κάθε συναίσθημα είναι σημαντικό.';

  @override
  String get infoTooltip => 'Τι είναι αυτό;';

  @override
  String get onboardingWelcomeTitle => 'Καλώς ήρθες στο CompAnIon!';

  @override
  String get onboardingWelcomeDesc => 'Αυτή δεν είναι απλώς μια εφαρμογή. Είναι μια παρουσία, ένας σύντροφος, ένας χώρος για την αλήθεια σου. Πάρε μια ανάσα και παρατήρησε: κρατάς ένα εργαλείο για σύνδεση με τον εαυτό σου, όχι απλώς για παραγωγικότητα.';

  @override
  String get onboardingEmotionTitle => 'Καταγραφή Συναισθήματος';

  @override
  String get onboardingEmotionDesc => 'Εδώ καταγράφεις πώς νιώθεις. Σταμάτα, σκέψου, και άφησε τον εαυτό σου να είναι ειλικρινής. Κάθε συναίσθημα είναι έγκυρο. Το CompAnIon ακούει, δεν κρίνει.';

  @override
  String get onboardingReflectionTitle => 'Λειτουργία Στοχασμού';

  @override
  String get onboardingReflectionDesc => 'Μετά από κάθε καταγραφή, προσκαλείσαι να στοχαστείς. Οι ερωτήσεις δεν είναι τεστ — είναι προσκλήσεις για βαθύτερη κατανόηση. Πάρε τον χρόνο σου.';

  @override
  String get onboardingRememberTitle => 'Remember Me';

  @override
  String get onboardingRememberDesc => 'Τίμησε αγαπημένους, θυμήσου ιδιαίτερες ημερομηνίες, κράτησε ζωντανές τις μνήμες. Αυτός είναι χώρος για φόρο τιμής, ευγνωμοσύνη και ήπια ανάμνηση.';

  @override
  String get onboardingPalliativeTitle => 'Ανακουφιστική Φροντίδα';

  @override
  String get onboardingPalliativeDesc => 'Βρες υποστήριξη και πόρους για σοβαρές διαγνώσεις και συναισθηματικές ανάγκες. Το CompAnIon είναι εδώ για κάθε στιγμή, ακόμα και τις δύσκολες.';

  @override
  String get onboardingSettingsTitle => 'Ρυθμίσεις & Απόρρητο';

  @override
  String get onboardingSettingsDesc => 'Όλα τα δεδομένα μένουν στη συσκευή σου. Εσύ επιλέγεις γλώσσα, θέμα και Care Mode. Το απόρρητο και η αξιοπρέπεια είναι στην καρδιά του CompAnIon.';

  @override
  String get onboardingFinalTitle => 'Τελική Σκέψη';

  @override
  String get onboardingFinalDesc => 'Το CompAnIon χτίστηκε με ενσυναίσθηση, παρουσία και σεβασμό. Καθώς ξεκινάς, ρώτα τον εαυτό σου: «Τι χρειάζομαι περισσότερο αυτή τη στιγμή;» Αυτός ο σύντροφος είναι εδώ για να σε βοηθήσει να θυμηθείς, να στοχαστείς και να νιώσεις λιγότερο μόνος.';

  @override
  String get start => 'Έναρξη';

  @override
  String get helpEmotionCheckIn => 'Αυτός είναι ο χώρος σου για να παρατηρήσεις και να καταγράψεις πώς νιώθεις. Κάθε συναίσθημα μετράει. Το CompAnIon είναι εδώ για να ακούσει, όχι να κρίνει. Πάρε μια στιγμή να στοχαστείς και να τιμήσεις την αλήθεια σου.';

  @override
  String get helpRememberMe => 'Εδώ μπορείς να τιμήσεις αγαπημένους, να θυμηθείς ιδιαίτερες ημερομηνίες και να κρατήσεις ζωντανές τις μνήμες. Η φόρος τιμής και η ευγνωμοσύνη είναι στην καρδιά αυτού του χώρου.';

  @override
  String get helpPalliativeCare => 'Βρες υποστήριξη και πόρους για σοβαρές διαγνώσεις και συναισθηματικές ανάγκες. Το CompAnIon προσφέρει παρουσία και φροντίδα, ακόμα και στις δύσκολες στιγμές.';

  @override
  String get helpSettings => 'Εξατομίκευσε την εμπειρία σου: γλώσσα, θέμα, γραμματοσειρά και Care Mode. Το απόρρητο είναι ιερό — τα δεδομένα σου μένουν στη συσκευή σου.';

  @override
  String get helpDefault => 'Ένας mindful, συναισθηματικά ευφυής σύντροφος. Εδώ για να σε βοηθήσει να επανασυνδεθείς με τον εαυτό σου.';
}
