/// Spectral Physics Engine - A mirror that speaks in frequencies.
/// Maps emotional and cognitive states onto spectrums to reflect balance and movement.

import 'package:flutter/material.dart';

// Defines the poles of our spectrums
class SpectralPole {
  final String name;
  final List<String> keywords;
  SpectralPole({required this.name, required this.keywords});
}

// A spectrum is a duality between two poles
class Spectrum {
  final String name;
  final SpectralPole poleA;
  final SpectralPole poleB;
  Spectrum({required this.name, required this.poleA, required this.poleB});
}

// The result of an analysis
class SpectralFeedback {
  final String spectrumName;
  final String message;
  final String prompt;
  final double position; // -1.0 (Pole A) to 1.0 (Pole B)

  SpectralFeedback({
    required this.spectrumName,
    required this.message,
    required this.prompt,
    required this.position,
  });
}

class SpectralEngine {
  static final List<Spectrum> _spectrums = [
    Spectrum(
      name: 'Connection',
      poleA: SpectralPole(name: 'Isolation', keywords: ['alone', 'lonely', 'disconnected', 'isolated', 'empty']),
      poleB: SpectralPole(name: 'Connection', keywords: ['together', 'connected', 'understood', 'seen', 'with', 'home']),
    ),
    Spectrum(
      name: 'Trust',
      poleA: SpectralPole(name: 'Fear', keywords: ['anxious', 'afraid', 'worried', 'scared', 'doubt']),
      poleB: SpectralPole(name: 'Trust', keywords: ['safe', 'trust', 'believe', 'hopeful', 'secure']),
    ),
    Spectrum(
      name: 'Energy',
      poleA: SpectralPole(name: 'Exhaustion', keywords: ['tired', 'exhausted', 'drained', 'weary', 'burnt out']),
      poleB: SpectralPole(name: 'Vitality', keywords: ['energized', 'alive', 'vibrant', 'excited', 'strong']),
    ),
    Spectrum(
      name: 'Clarity',
      poleA: SpectralPole(name: 'Confusion', keywords: ['confused', 'lost', 'uncertain', 'stuck', 'blurry']),
      poleB: SpectralPole(name: 'Clarity', keywords: ['clear', 'focused', 'certain', 'knowing', 'purpose']),
    ),
  ];

  /// Analyzes user's recent state and returns feedback on their spectral position.
  static SpectralFeedback? analyze(List<Map<String, String>> history) {
    if (history.isEmpty) return null;

    final recentEntry = history.first;
    final textCorpus = ('${recentEntry['emotion']} ${recentEntry['comment']} ${recentEntry['reflection']}').toLowerCase();

    for (final spectrum in _spectrums) {
      int scoreA = 0;
      int scoreB = 0;

      for (final keyword in spectrum.poleA.keywords) {
        if (textCorpus.contains(keyword)) scoreA++;
      }
      for (final keyword in spectrum.poleB.keywords) {
        if (textCorpus.contains(keyword)) scoreB++;
      }

      if (scoreA > 0 || scoreB > 0) {
        double position = (scoreB - scoreA) / (scoreA + scoreB).toDouble();
        String message;
        String prompt;

        if (position < -0.5) {
          message = "I notice you're close to the edge of '${spectrum.poleA.name}'.";
          prompt = "Have you visited '${spectrum.poleB.name}' lately?";
        } else if (position > 0.5) {
          message = "It feels like you're resonating with '${spectrum.poleB.name}'.";
          prompt = "What helps you stay in this frequency?";
        } else {
          message = "You seem to be balancing between '${spectrum.poleA.name}' and '${spectrum.poleB.name}'.";
          prompt = "Do you want to hold steady, or shift?";
        }

        return SpectralFeedback(
          spectrumName: spectrum.name,
          message: message,
          prompt: prompt,
          position: position,
        );
      }
    }
    return null;
  }
}
