import 'package:flutter/material.dart';

/// HamiltonianTuning – Helps users observe and shift their internal energy state
/// Based on the principle that changing your inner energy changes your trajectory

class HamiltonianTuning extends StatefulWidget {
  final String currentEmotion;
  final String currentContext;
  final VoidCallback? onTuningComplete;

  const HamiltonianTuning({
    super.key,
    required this.currentEmotion,
    required this.currentContext,
    this.onTuningComplete,
  });

  @override
  State<HamiltonianTuning> createState() => _HamiltonianTuningState();
}

class _HamiltonianTuningState extends State<HamiltonianTuning>
    with SingleTickerProviderStateMixin {
  late AnimationController _energyController;
  late Animation<double> _energyAnimation;
  double _currentEnergy = 0.5;
  String _energyState = 'neutral';

  @override
  void initState() {
    super.initState();
    _energyController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _energyAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _energyController, curve: Curves.easeInOut),
    );
    _energyController.repeat(reverse: true);
    _detectCurrentEnergy();
  }

  void _detectCurrentEnergy() {
    final emotion = widget.currentEmotion.toLowerCase();
    if (emotion.contains('angry') || emotion.contains('anxious')) {
      _currentEnergy = 0.8;
      _energyState = 'high_tension';
    } else if (emotion.contains('sad') || emotion.contains('tired')) {
      _currentEnergy = 0.2;
      _energyState = 'low_flow';
    } else if (emotion.contains('happy') || emotion.contains('excited')) {
      _currentEnergy = 0.7;
      _energyState = 'harmonious';
    } else {
      _currentEnergy = 0.5;
      _energyState = 'neutral';
    }
  }

  Color _getEnergyColor() {
    if (_currentEnergy > 0.7) return Colors.red[400]!;
    if (_currentEnergy > 0.5) return Colors.orange[400]!;
    if (_currentEnergy > 0.3) return Colors.green[400]!;
    return Colors.blue[400]!;
  }

  String _getEnergyMessage() {
    switch (_energyState) {
      case 'high_tension':
        return 'Your energy carries intensity. What if you channeled this fire into something that serves you?';
      case 'low_flow':
        return 'Your energy moves like still water. Sometimes the gentlest currents carve the deepest channels.';
      case 'harmonious':
        return 'Your energy flows with clarity. Notice how this state feels—what maintains it?';
      default:
        return 'Your energy is balanced. From this center, many directions become possible.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[50],
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.tune, color: Colors.purple[800], size: 28),
                const SizedBox(width: 12),
                Text(
                  'Hamiltonian Tuning',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.purple[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Your internal energy shapes your path through reality.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.purple[700],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple[300]!),
              ),
              child: Stack(
                children: [
                  // Energy field visualization
                  AnimatedBuilder(
                    animation: _energyAnimation,
                    builder: (context, child) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              _getEnergyColor().withOpacity(0.1),
                              _getEnergyColor().withOpacity(0.3 * _energyAnimation.value),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Energy level indicator
                  Positioned(
                    left: 16,
                    top: 16,
                    bottom: 16,
                    child: Container(
                      width: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[300],
                      ),
                      child: FractionallySizedBox(
                        heightFactor: _currentEnergy,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _getEnergyColor(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Energy state text
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Text(
                      _energyState.replaceAll('_', ' ').toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getEnergyColor(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getEnergyMessage(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple[700],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Gentle inquiry: What would shift your energy toward where you want to be?',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.purple[600],
              ),
            ),
            if (widget.onTuningComplete != null) ...[
              const SizedBox(height: 16),
              Center(
                child: OutlinedButton(
                  onPressed: widget.onTuningComplete,
                  child: const Text('Continue with Awareness'),
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
    _energyController.dispose();
    super.dispose();
  }
}
