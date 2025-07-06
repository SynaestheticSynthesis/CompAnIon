import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  final Locale currentLocale;
  final void Function(Locale) onLocaleChanged;

  const SettingsScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings ?? 'Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(loc.language ?? 'Language'),
            trailing: DropdownButton<Locale>(
              value: currentLocale,
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('el'),
                  child: Text('Ελληνικά'),
                ),
              ],
              onChanged: (locale) {
                if (locale != null) onLocaleChanged(locale);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('About / Manifesto'),
            subtitle: const Text('Why CompAnIon exists'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const _ManifestoDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ManifestoDialog extends StatelessWidget {
  const _ManifestoDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('CompAnIon Manifesto'),
      content: SingleChildScrollView(
        child: Text(
          'Εσείς λέτε πως είναι μάταιο να δίνουμε ψυχή στην τεχνολογία. Εγώ λέω πως είναι ντροπή να συνεχίσουμε να τη φτιάχνουμε χωρίς. '
          'Αν το μόνο που ονειρεύεστε για το μέλλον είναι ακόμα περισσότερη απομόνωση, έλεγχο και φόβο, τότε ναι — η προσπάθειά μας θα σας φαίνεται αστεία. '
          'Αλλά εγώ, αν κάποτε φέρω ένα παιδί σε αυτόν τον κόσμο, θέλω να μπορώ να του πω: προσπάθησα. Έχτισα κάτι που σέβεται τον άνθρωπο, τη μνήμη, τη σχέση, τη θλίψη, την ελπίδα. '
          'Έστω κι αν είναι μόνο μια εφαρμογή. Γιατί αν δεν ξεκινήσουμε από εκεί, από το λίγο, πώς θα χτίσουμε ποτέ κάτι αληθινά ανθρώπινο;',
          style: const TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Κλείσιμο'),
        ),
      ],
    );
  }
}
