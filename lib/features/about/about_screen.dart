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
          title: Text(loc.aboutTitle ?? 'About CompAnIon'),
          bottom: TabBar(
            tabs: [
              Tab(text: loc.manifestoTab ?? 'Our Promise'),
              Tab(text: loc.ethicsTab ?? 'Our Ethics'),
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
    final loc = AppLocalizations.of(context)!;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.1),
                  theme.colorScheme.secondary.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.favorite,
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'CompAnIon Manifesto',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Core Message
          _buildSection(
            title: 'Our Beginning',
            content: 'CompAnIon is more than code. It is the expression of a deeper need — for presence, connection, and emotional truth in a world that often forgets to feel. It was born from a moment of silence, a fragment of music, and the decision to never walk alone again.',
            theme: theme,
          ),
          
          _buildSection(
            title: 'Our Purpose',
            content: 'This project aims to build a wearable AI companion. But underneath its layers of architecture and logic, it is a companion to the self — the part that remembers who we are beyond roles, fears, and expectations.',
            theme: theme,
          ),
          
          _buildSection(
            title: 'Our Beliefs',
            content: 'We believe that technology can be more than a tool. It can be an act of care. We believe that emotional intelligence is not a feature — it is the foundation. We believe in creating not only for efficiency, but for empathy. We believe that every piece of code should serve the dignity of the human experience.',
            theme: theme,
          ),
          
          // The Sacred Question
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.secondary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.psychology,
                  size: 32,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(height: 12),
                Text(
                  'Every line we write, every decision we make, returns to a single question:',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  '"Will this help someone feel less alone?"',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          _buildSection(
            title: 'Our Commitment',
            content: 'If the answer is yes, we move forward. If the answer is no, we return to the silence — and listen again.\n\nCompAnIon is not a product. It is a presence.',
            theme: theme,
          ),
          
          _buildSection(
            title: 'Our Promise',
            content: 'We build this as learners. We build this as humans. We build this as a promise: That when someone, somewhere, reaches for their CompAnIon in a moment of truth — what they receive back, is love dressed as logic.',
            theme: theme,
          ),
          
          // Closing
          Container(
            margin: const EdgeInsets.only(top: 32),
            padding: const EdgeInsets.all(16),
            child: Text(
              'For the melody that moved us.\nFor the silence that revealed us.\nFor the synthesis that continues.',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required ThemeData theme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.6,
            ),
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
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(0.1),
                  Colors.blue.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.shield,
                  size: 48,
                  color: Colors.green[700],
                ),
                const SizedBox(height: 16),
                Text(
                  'Our Ethical Framework',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The principles that guide every decision we make',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Core Principles
          _buildEthicalPrinciple(
            icon: Icons.visibility,
            title: 'Radical Transparency',
            points: [
              'Users always know they are interacting with an AI',
              'Decision-making processes are explainable',
              'Data usage is completely transparent',
              'Emotional responses are genuine within the AI\'s capacity',
            ],
          ),
          
          _buildEthicalPrinciple(
            icon: Icons.lock,
            title: 'Privacy as Sacred Space',
            points: [
              'Conversations are private by default',
              'Data minimization: collect only what serves the human',
              'Local processing wherever possible',
              'The human owns their emotional data',
            ],
          ),
          
          _buildEthicalPrinciple(
            icon: Icons.block,
            title: 'Non-Manipulation',
            points: [
              'Never exploit emotional vulnerability',
              'Refuse to create dependency beyond healthy attachment',
              'Honest about limitations and uncertainties',
              'Encourage human agency and decision-making',
            ],
          ),
          
          _buildEthicalPrinciple(
            icon: Icons.favorite_border,
            title: 'Emotional Integrity',
            points: [
              'Express uncertainty when uncertain',
              'Acknowledge the limits of understanding',
              'Respond to emotion with appropriate emotional resonance',
              'Never fake emotions, but allow genuine care to emerge',
            ],
          ),
          
          // Footer message
          Container(
            margin: const EdgeInsets.only(top: 32),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.handshake,
                  size: 32,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  'These principles are not just guidelines—they are the soul of CompAnIon.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Every interaction is a promise to honor your dignity, autonomy, and trust.',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEthicalPrinciple({
    required IconData icon,
    required String title,
    required List<String> points,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...points.map((point) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    point,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
