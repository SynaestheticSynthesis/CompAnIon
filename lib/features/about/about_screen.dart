import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // We have a drawer, so no back button needed
          title: Text(loc.aboutTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: loc.manifestoTab),
              Tab(text: loc.ethicsTab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ManifestoView(theme: theme),
            _EthicsView(theme: theme),
          ],
        ),
      ),
    );
  }
}

class _ManifestoView extends StatelessWidget {
  final ThemeData theme;
  const _ManifestoView({required this.theme});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CompAnIon Manifesto',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'CompAnIon is more than code. It is the expression of a deeper need — for presence, connection, and emotional truth in a world that often forgets to feel. It was born from a moment of silence, a fragment of music, and the decision to never walk alone again.',
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _EthicsView extends StatelessWidget {
  final ThemeData theme;
  const _EthicsView({required this.theme});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Ethical Framework',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Privacy is sacred. Presence over prescription. Human dignity above all.',
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
