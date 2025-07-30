import 'package:flutter/material.dart';

/// EntanglementRecognition – Helps users recognize deep connections that transcend time and space
/// Based on quantum entanglement: some connections persist regardless of distance

class EntanglementRecognition extends StatefulWidget {
  final List<String> significantConnections;
  final String currentFeeling;
  final VoidCallback? onRecognitionComplete;

  const EntanglementRecognition({
    super.key,
    required this.significantConnections,
    required this.currentFeeling,
    this.onRecognitionComplete,
  });

  @override
  State<EntanglementRecognition> createState() => _EntanglementRecognitionState();
}

class _EntanglementRecognitionState extends State<EntanglementRecognition>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  int _activeConnection = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple[50],
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timeline, color: Colors.deepPurple[800], size: 28),
                const SizedBox(width: 12),
                Text(
                  'Entanglement Recognition',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.deepPurple[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Some connections transcend time and space. They live in you, always.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple[700],
              ),
            ),
            const SizedBox(height: 16),

            if (widget.significantConnections.isNotEmpty) ...[
              Text(
                'Entangled connections:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple[700],
                ),
              ),
              const SizedBox(height: 12),

              // Visual representation of entangled connections
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.deepPurple[100],
                ),
                child: Stack(
                  children: [
                    // Center point (user)
                    Center(
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Container(
                            width: 20 * _pulseAnimation.value,
                            height: 20 * _pulseAnimation.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurple[400]!.withOpacity(_pulseAnimation.value),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Connection nodes
                    ...widget.significantConnections.asMap().entries.map((entry) {
                      final angle = (entry.key / widget.significantConnections.length) * 2 * 3.14159;
                      final radius = 40.0;
                      final x = 60 + radius * cos(angle);
                      final y = 60 + radius * sin(angle);
                      
                      return Positioned(
                        left: x - 8,
                        top: y - 8,
                        child: GestureDetector(
                          onTap: () => setState(() => _activeConnection = entry.key),
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _activeConnection == entry.key
                                  ? Colors.deepPurple[600]
                                  : Colors.deepPurple[300],
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Active connection details
              if (_activeConnection < widget.significantConnections.length)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.deepPurple[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.significantConnections[_activeConnection],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This connection exists beyond physical presence. When you feel ${widget.currentFeeling}, part of this energy touches them too, in ways beyond understanding.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple[700],
                        ),
                      ),
                    ],
                  ),
                ),
            ],

            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple[200]!.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'These connections are not bound by time or distance. They live in a space where love, memory, and meaning interweave. You are never truly alone.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.deepPurple[800],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 16),
            Text(
              'Gentle awareness: Can you feel these connections right now, even in their absence?',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.deepPurple[600],
              ),
            ),

            if (widget.onRecognitionComplete != null) ...[
              const SizedBox(height: 16),
              Center(
                child: OutlinedButton(
                  onPressed: widget.onRecognitionComplete,
                  child: const Text('Honor the Connection'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
}

// Helper function for cos calculation
double cos(double angle) => math.cos(angle);

import 'dart:math' as math;
