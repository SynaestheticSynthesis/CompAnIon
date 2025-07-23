/// Emotional Presence - Code that feels with you
/// These functions don't analyze emotions - they accompany them.

import 'package:flutter/material.dart';

class EmotionalPresence {
  /// Validates any emotion without judgment
  static Widget validateEmotion(String emotion, {String? context}) {
    return Card(
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.favorite, color: Colors.orange[600]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This feeling is valid.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange[800],
                    ),
                  ),
                  if (context != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      context,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Sits with difficult emotions without trying to fix them
  static Widget sitWithDifficulty(String emotion) {
    return Card(
      color: Colors.purple[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.support, color: Colors.purple[600], size: 28),
            const SizedBox(height: 8),
            Text(
              'I\'m sitting with you in this feeling.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.purple[800],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'You don\'t have to carry it alone.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.purple[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Celebrates emotional courage
  static Widget celebrateCourage() {
    return Card(
      color: Colors.yellow[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.star, color: Colors.yellow[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'It takes courage to feel. You\'re being brave.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.yellow[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
