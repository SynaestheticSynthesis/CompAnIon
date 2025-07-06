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
