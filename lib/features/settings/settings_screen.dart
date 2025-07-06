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
        ],
      ),
    );
  }
}
