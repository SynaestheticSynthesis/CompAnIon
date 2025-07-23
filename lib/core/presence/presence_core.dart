/// Presence Core - The heart of compassionate code
/// Every function here is designed to offer presence, not prescription.
/// Code as care. Logic as love.

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class PresenceCore {
  /// Offers gentle presence without judgment or advice
  static Future<void> offerPresence(
    BuildContext context, 
    String message, {
    String? title,
    bool allowDismiss = true,
  }) async {
    final loc = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    
    await showDialog(
      context: context,
      barrierDismissible: allowDismiss,
      builder: (context) => AlertDialog(
        title: Text(title ?? (locale == 'el' ? 'Παρουσία' : 'Presence')),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(locale == 'el' ? 'Ευχαριστώ' : 'Thank you'),
          ),
        ],
      ),
    );
  }

  /// Asks permission before offering any guidance or reflection
  static Future<bool> askPermission(
    BuildContext context,
    String question, {
    String? explanation,
  }) async {
    final locale = Localizations.localeOf(context).languageCode;
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale == 'el' ? 'Μπορώ να προτείνω κάτι;' : 'May I suggest something?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question),
            if (explanation != null) ...[
              const SizedBox(height: 8),
              Text(
                explanation,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(locale == 'el' ? 'Όχι τώρα' : 'Not now'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(locale == 'el' ? 'Ναι, παρακαλώ' : 'Yes, please'),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }

  /// Reflects what the user says without interpretation
  static Widget createMirror(String userInput, {String? prefix}) {
    final locale = Localizations.localeOf(context).languageCode;
    final reflectionPrefix = prefix ?? 
      (locale == 'el' ? 'Ακούω ότι...' : 'I hear that...');
    
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.mirror, color: Colors.blue[600]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$reflectionPrefix $userInput',
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Offers choice without pressure
  static Widget createChoice(
    String question,
    List<String> options,
    Function(String) onChoice, {
    bool allowSkip = true,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            ...options.map((option) => 
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: OutlinedButton(
                  onPressed: () => onChoice(option),
                  child: Text(option),
                ),
              ),
            ),
            if (allowSkip) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => onChoice('skip'),
                child: const Text('Skip for now'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Creates space for silence and breathing
  static Widget createBreathingSpace({
    String? message,
    Duration? duration,
  }) {
    final locale = Localizations.localeOf(context).languageCode;
    final defaultMessage = locale == 'el' 
      ? 'Πάρε μια βαθιά ανάσα. Είμαι εδώ.'
      : 'Take a deep breath. I\'m here.';
    
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.self_improvement, size: 32, color: Colors.green[600]),
            const SizedBox(height: 12),
            Text(
              message ?? defaultMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            if (duration != null) ...[
              const SizedBox(height: 16),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: duration,
                builder: (context, value, child) => LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.green[100],
                  color: Colors.green[400],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
