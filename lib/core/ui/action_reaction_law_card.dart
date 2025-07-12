import 'package:flutter/material.dart';

class ActionReactionLawCard extends StatelessWidget {
  final String action;
  final String reaction;
  final int intensity;
  final String message;

  const ActionReactionLawCard({
    required this.action,
    required this.reaction,
    required this.intensity,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color barColor;
    if (intensity >= 7) {
      barColor = Colors.redAccent;
    } else if (intensity >= 4) {
      barColor = Colors.orangeAccent;
    } else {
      barColor = theme.colorScheme.secondary;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: barColor.withOpacity(0.25),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: barColor,
          width: 2.5,
        ),
      ),
      child: Card(
        color: theme.brightness == Brightness.dark
            ? Colors.blueGrey[900]
            : Colors.blue[50],
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.sync_alt, color: Colors.blueAccent, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    "Newton's Third Law",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: barColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Action: $action",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "Reaction: $reaction",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text("Intensity: ", style: const TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 80,
                    child: LinearProgressIndicator(
                      value: intensity / 10,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      color: barColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("$intensity/10"),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  fontSize: 15,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white70
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
