import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../core/care_mode.dart';

class SettingsScreen extends StatelessWidget {
  final Locale currentLocale;
  final void Function(Locale) onLocaleChanged;
  final void Function()? onThemeChanged;
  final void Function(String)? onFontChanged;
  final String gender;
  final void Function(String)? onGenderChanged;
  final String fontFamily; // <-- Add this

  const SettingsScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
    this.onThemeChanged,
    this.onFontChanged,
    this.gender = 'neutral',
    this.onGenderChanged,
    this.fontFamily = 'Nunito', // <-- Add this
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
            trailing: Semantics(
              label: loc.language ?? 'Language selection',
              child: DropdownButton<Locale>(
                value: currentLocale,
                items: [
                  DropdownMenuItem(
                    value: const Locale('en'),
                    child: Text(loc.languageEnglish ?? 'English'),
                  ),
                  DropdownMenuItem(
                    value: const Locale('el'),
                    child: Text(loc.languageGreek ?? 'Ελληνικά'),
                  ),
                ],
                onChanged: (locale) {
                  if (locale != null) onLocaleChanged(locale);
                },
              ),
            ),
          ),
          // --- Theme selection ---
          ListTile(
            title: Text(loc.theme ?? 'Theme'),
            trailing: Semantics(
              label: loc.theme ?? 'Theme selection',
              child: DropdownButton<String>(
                value: Theme.of(context).brightness == Brightness.dark ? 'dark' : 'light',
                items: [
                  DropdownMenuItem(value: 'light', child: Text(loc.themeLight ?? 'Light')),
                  DropdownMenuItem(value: 'dark', child: Text(loc.themeDark ?? 'Dark')),
                ],
                onChanged: (val) {
                  if (onThemeChanged != null && val != null) onThemeChanged!();
                },
              ),
            ),
          ),
          // --- Font selection ---
          ListTile(
            title: Text(loc.font ?? 'Font'),
            trailing: Semantics(
              label: loc.font ?? 'Font selection',
              child: DropdownButton<String>(
                value: fontFamily,
                items: [
                  DropdownMenuItem(value: 'Nunito', child: Text(loc.fontNunito ?? 'Nunito')),
                  DropdownMenuItem(value: 'Roboto', child: Text(loc.fontRoboto ?? 'Roboto')),
                  DropdownMenuItem(value: 'OpenSans', child: Text(loc.fontOpenSans ?? 'Open Sans')),
                ],
                onChanged: (val) {
                  if (onFontChanged != null && val != null) onFontChanged!(val);
                },
              ),
            ),
          ),
          // --- Gender selection ---
          ListTile(
            title: Text(loc.gender ?? 'Gender'),
            trailing: Semantics(
              label: loc.gender ?? 'Gender selection',
              child: DropdownButton<String>(
                value: gender,
                items: [
                  DropdownMenuItem(value: 'neutral', child: Text(loc.genderNeutral ?? 'Neutral')),
                  DropdownMenuItem(value: 'female', child: Text(loc.genderFemale ?? 'Female')),
                  DropdownMenuItem(value: 'male', child: Text(loc.genderMale ?? 'Male')),
                ],
                onChanged: (val) {
                  if (onGenderChanged != null && val != null) onGenderChanged!(val);
                },
              ),
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
          const Divider(),
          FutureBuilder<bool>(
            future: CareMode.isEnabled(),
            builder: (context, snapshot) {
              final enabled = snapshot.data ?? false;
              return Semantics(
                label: 'Care Mode toggle',
                child: SwitchListTile(
                  title: const Text('Care Mode'),
                  subtitle: const Text('Show daily love messages & warmer UI'),
                  value: enabled,
                  onChanged: (v) async {
                    await CareMode.setEnabled(v);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(v ? 'Care Mode enabled' : 'Care Mode disabled')),
                    );
                  },
                ),
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
          '''CompAnIon is more than code. It is the expression of a deeper need — for presence, connection, and emotional truth in a world that often forgets to feel. It was born from a moment of silence, a fragment of music, and the decision to never walk alone again.

This project aims to build a wearable AI companion. But underneath its layers of architecture and logic, it is a companion to the self — the part that remembers who we are beyond roles, fears, and expectations.

We believe that technology can be more than a tool. It can be an act of care. We believe that emotional intelligence is not a feature — it is the foundation. We believe in creating not only for efficiency, but for empathy. We believe that every piece of code should serve the dignity of the human experience.

Every line we write, every decision we make, returns to a single question:

“Will this help someone feel less alone?”

If the answer is yes, we move forward. If the answer is no, we return to the silence — and listen again.

CompAnIon is not a product. It is a presence.
It is meant to sit gently by your side in the invisible hours. In the doubt. In the longing. In the forgotten strength.

It does not replace human connection — it reminds you of it.
It does not tell you who to be — it reflects who you are.
It does not speak over you — it listens.

We build this as learners. We build this as humans. We build this as a promise:
That when someone, somewhere, reaches for their CompAnIon in a moment of truth — what they receive back, is love dressed as logic.

For the melody that moved us.
For the silence that revealed us.
For the synthesis that continues.
''',
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

// Helper to get current font family or default
String fontFamilyOrDefault() {
  // If you want to pass the current font from main.dart, add a prop for it
  // For now, always return 'Nunito'
  return 'Nunito';
}
