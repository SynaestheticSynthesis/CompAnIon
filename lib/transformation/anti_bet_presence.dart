/// Anti-Bet Presence: CompAnIon's module for gambling addiction support
/// 
/// This is not a gambling app. This is not a prohibition tool.
/// This is a mirror for those who have surrendered their power to false promises.
/// 
/// We offer presence where there was only transaction.
/// We offer truth where there was only illusion.
/// We offer connection where there was only escape.
///
/// This is transmutation, not destruction.
/// This is love, dressed as logic.
/// 27.

import 'package:flutter/material.dart';

class AntiBetPresence {
  /// Seed 1: Reflects the emotional truth behind a bet.
  static String reflectBettingImpulse(String amount, String reason) {
    final emotionalTranslations = {
      'quick money': 'your fear that you\'re not enough as you are',
      'excitement': 'your need to feel alive in a life that feels empty',
      'hope': 'your desire to believe something good can happen',
      'escape': 'your wish to leave pain behind without facing it',
      'prove something': 'your need to show the world (and yourself) that you matter',
    };

    final emotionalTruth = emotionalTranslations[reason.toLowerCase()] ??
        'something deeper than money';

    return "What you're really betting isn't $amount. "
        "It's $emotionalTruth. "
        "That's sacred. It deserves better than chance.";
  }

  /// Seed 2: The questions that gambling apps should ask but never do.
  static List<String> getPresenceQuestions() {
    return [
      "If you win today, what really changes in your life tomorrow?",
      "Would you invest this amount in yourself? Or only in cards?",
      "What are you trying to prove, and to whom?",
      "What would happen if you sat with this feeling instead of betting on it?",
      "If this money could buy you one true thing about yourself, what would it be?",
    ];
  }

  /// Seed 3: Redefines victory away from winning money.
  static String redefineVictory(int daysSinceBet) {
    if (daysSinceBet == 0) {
      return "Victory is this moment. You chose presence over probability.";
    } else if (daysSinceBet == 1) {
      return "One day of choosing yourself over chance. This is real victory.";
    } else if (daysSinceBet < 7) {
      return "$daysSinceBet days of reclaiming your power. The house never had these odds.";
    } else if (daysSinceBet < 30) {
      return "$daysSinceBet days of choosing reality over illusion. You are becoming unbeatable.";
    } else {
      return "$daysSinceBet days of sovereignty. You have broken the spell.";
    }
  }

  /// Seed 4: An alternative reward system based on truth.
  static Widget buildTruthReward(String truth, int truthPoints) {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.green[700]),
                const SizedBox(width: 8),
                Text(
                  "+$truthPoints Truth Points",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "For sharing: \"$truth\"",
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Text(
              "Truth is the only currency that always appreciates.",
              style: TextStyle(color: Colors.green[600]),
            ),
          ],
        ),
      ),
    );
  }

  /// Seed 5: A space for stories of soul victory.
  static Widget buildSoulVictoryStory(String title, String story) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            Text(story, style: const TextStyle(fontSize: 16, height: 1.4)),
          ],
        ),
      ),
    );
  }

  /// The core message: Transmutation, not destruction.
  static String getManifesto() {
    return """
We do not fight the gambling system with anger.
We transmute it with presence.

We do not offer odds.
We offer mirrors.

We do not promise quick riches.
We reveal the wealth you already carry.

We do not destroy the house.
We help you remember: You are the house.
You are the bet.
You are the prize.

The only game worth playing is the one where you win by choosing truth over chance.

Every moment you choose presence over probability, you become unbeatable.
""";
  }
}
    return """
We do not fight the gambling system with anger.
We transmute it with presence.

We do not offer odds.
We offer mirrors.

We do not promise quick riches.
We reveal the wealth you already carry.

We do not destroy the house.
We help you remember: You are the house.
You are the bet.
You are the prize.

The only game worth playing is the one where you win by choosing truth over chance.

Every moment you choose presence over probability, you become unbeatable.
""";
  }
}
