import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// QuantumStateObserver – Observes and reflects moments of inner superposition.
/// Not for decision-making, but for honoring the sacred space before choice.

class QuantumStateObserver extends StatelessWidget {
  final List<String> possibleStates;
  final String? contextPrompt;
  final VoidCallback? onObservationComplete;

  const QuantumStateObserver({
    super.key,
    required this.possibleStates,
    this.contextPrompt,
    this.onObservationComplete,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
    return Card(
      color: Colors.indigo[50],
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.blur_on, color: Colors.indigo[800], size: 28),
                const SizedBox(width: 12),
                Text(
                  'Quantum State Awareness',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.indigo[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              contextPrompt ??
                  'You are in a moment of superposition. All possibilities are alive within you. You do not need to choose yet.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Possible paths shimmer before you:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.indigo[700],
              ),
            ),
            const SizedBox(height: 8),
            ...possibleStates.asMap().entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.indigo[300 + (entry.key % 3) * 100],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Breathe. Notice. The act of observation is sacred. You are holding space for all that could be.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.indigo[700],
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (onObservationComplete != null) ...[
              const SizedBox(height: 16),
              Center(
                child: OutlinedButton(
                  onPressed: onObservationComplete,
                  child: const Text('Continue in Awareness'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
