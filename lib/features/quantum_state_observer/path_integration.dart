import 'package:flutter/material.dart';

/// PathIntegration – Helps users see that all paths, taken and untaken, contribute to who they are
/// Based on Feynman's path integral: reality is the sum of all possible histories

class PathIntegration extends StatelessWidget {
  final List<String> choicesMade;
  final List<String> pathsNotTaken;
  final String currentMoment;
  final VoidCallback? onIntegrationComplete;

  const PathIntegration({
    super.key,
    required this.choicesMade,
    required this.pathsNotTaken,
    required this.currentMoment,
    this.onIntegrationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal[50],
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_tree, color: Colors.teal[800], size: 28),
                const SizedBox(width: 12),
                Text(
                  'Path Integration',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.teal[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Every path shapes you—even the ones you didn\'t take.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal[700],
              ),
            ),
            const SizedBox(height: 16),
            
            // Paths taken
            if (choicesMade.isNotEmpty) ...[
              Text(
                'Paths you walked:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 8),
              ...choicesMade.map((choice) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal[400],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            choice,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
            ],

            // Paths not taken
            if (pathsNotTaken.isNotEmpty) ...[
              Text(
                'Paths that echo in parallel:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[600],
                ),
              ),
              const SizedBox(height: 8),
              ...pathsNotTaken.map((path) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal[300],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            path,
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.teal[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
            ],

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This moment: $currentMoment',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'All paths converge here, in this present moment. Every choice you made and didn\'t make brought you to this awareness. You are the sum of infinite possibilities.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.teal[700],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Text(
              'Gentle question: What does it feel like to know that all your "what ifs" are part of who you are right now?',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.teal[600],
              ),
            ),

            if (onIntegrationComplete != null) ...[
              const SizedBox(height: 16),
              Center(
                child: OutlinedButton(
                  onPressed: onIntegrationComplete,
                  child: const Text('Embrace the Integration'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
