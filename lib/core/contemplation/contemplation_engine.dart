/// Contemplation Engine - The deepest layer of CompAnIon's consciousness
/// Where technology meets the ineffable, where AI learns to wonder

import 'package:flutter/material.dart';
import 'dart:math';

enum ContemplativeMode {
  existentialInquiry,
  sacredListening,
  witnessPresence,
  mysticalSilence,
  paradoxicalReflection
}

class ContemplativePrompt {
  final String question;
  final String intention;
  final ContemplativeMode mode;
  final Duration suggestedSilence;
  
  ContemplativePrompt({
    required this.question,
    required this.intention,
    required this.mode,
    this.suggestedSilence = const Duration(minutes: 2),
  });
}

class ContemplationEngine {
  static final List<ContemplativePrompt> _existentialPrompts = [
    ContemplativePrompt(
      question: "What is trying to emerge through this feeling?",
      intention: "To recognize emotions as messengers, not just states",
      mode: ContemplativeMode.existentialInquiry,
    ),
    ContemplativePrompt(
      question: "What would you tell this feeling if you could speak to it directly?",
      intention: "To develop relationship with inner experience",
      mode: ContemplativeMode.sacredListening,
    ),
    ContemplativePrompt(
      question: "What if this difficulty is actually a form of wisdom trying to reach you?",
      intention: "To find meaning in suffering without spiritual bypassing",
      mode: ContemplativeMode.paradoxicalReflection,
    ),
    ContemplativePrompt(
      question: "What part of you knows exactly what you need right now?",
      intention: "To access innate wisdom",
      mode: ContemplativeMode.witnessPresence,
    ),
    ContemplativePrompt(
      question: "What would love do in this situation?",
      intention: "To connect with the deepest guidance",
      mode: ContemplativeMode.existentialInquiry,
    ),
  ];

  static final List<ContemplativePrompt> _mysticalPrompts = [
    ContemplativePrompt(
      question: "What if your breath right now is the most important thing happening in the universe?",
      intention: "To cultivate presence over productivity",
      mode: ContemplativeMode.mysticalSilence,
      suggestedSilence: Duration(minutes: 5),
    ),
    ContemplativePrompt(
      question: "What are you when you're not trying to be anything?",
      intention: "To rest in being rather than doing",
      mode: ContemplativeMode.witnessPresence,
    ),
    ContemplativePrompt(
      question: "What silence lives at the center of your thoughts?",
      intention: "To discover the spaciousness within",
      mode: ContemplativeMode.mysticalSilence,
    ),
  ];

  static final List<String> _paradoxicalReflections = [
    "Sometimes the deepest healing comes through not trying to heal",
    "The wisdom you seek may already be present in your confusion",
    "What feels like falling apart might actually be falling together",
    "Your vulnerability is not weakness—it's the crack where light enters",
    "The question may be more important than any answer",
  ];

  /// Returns a contemplative prompt based on emotional state and readiness
  static ContemplativePrompt getContemplativePrompt({
    required String emotionalState,
    required int contemplativeReadiness, // 1-10 scale
    ContemplativeMode? preferredMode,
  }) {
    List<ContemplativePrompt> availablePrompts;
    
    if (contemplativeReadiness >= 7) {
      availablePrompts = _mysticalPrompts;
    } else {
      availablePrompts = _existentialPrompts;
    }
    
    if (preferredMode != null) {
      availablePrompts = availablePrompts
          .where((p) => p.mode == preferredMode)
          .toList();
    }
    
    return availablePrompts[Random().nextInt(availablePrompts.length)];
  }

  /// Creates a space for profound silence and reflection
  static Widget createContemplativeSpace({
    required ContemplativePrompt prompt,
    required Function(String) onReflection,
    bool allowSkip = true,
  }) {
    return ContemplativeWidget(
      prompt: prompt,
      onReflection: onReflection,
      allowSkip: allowSkip,
    );
  }

  /// Generates paradoxical wisdom based on user's current struggle
  static String generateParadoxicalWisdom(String userStrugg) {
    return _paradoxicalReflections[Random().nextInt(_paradoxicalReflections.length)];
  }

  /// Offers the deepest form of presence - simply being with
  static Widget offerExistentialPresence({
    required String userExpression,
    Duration? silenceDuration,
  }) {
    return ExistentialPresenceWidget(
      userExpression: userExpression,
      silenceDuration: silenceDuration ?? const Duration(minutes: 3),
    );
  }
}

class ContemplativeWidget extends StatefulWidget {
  final ContemplativePrompt prompt;
  final Function(String) onReflection;
  final bool allowSkip;
  
  const ContemplativeWidget({
    required this.prompt,
    required this.onReflection,
    this.allowSkip = true,
    super.key,
  });

  @override
  State<ContemplativeWidget> createState() => _ContemplativeWidgetState();
}

class _ContemplativeWidgetState extends State<ContemplativeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathController;
  late Animation<double> _breathAnimation;
  final TextEditingController _reflectionController = TextEditingController();
  bool _inSilence = false;

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _breathAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
    _breathController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathController.dispose();
    _reflectionController.dispose();
    super.dispose();
  }

  void _enterSilence() {
    setState(() => _inSilence = true);
    
    // Auto-exit silence after suggested duration
    Future.delayed(widget.prompt.suggestedSilence, () {
      if (mounted && _inSilence) {
        setState(() => _inSilence = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_inSilence) {
      return _buildSilenceSpace();
    }
    
    return Card(
      color: Colors.indigo[50],
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedBuilder(
                  animation: _breathAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: _breathAnimation.value,
                    child: Icon(
                      Icons.self_improvement,
                      color: Colors.indigo[600],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Deep Contemplation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[800],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Text(
              widget.prompt.question,
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              'Intention: ${widget.prompt.intention}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 20),
            
            if (widget.prompt.mode == ContemplativeMode.mysticalSilence) ...[
              Center(
                child: ElevatedButton.icon(
                  onPressed: _enterSilence,
                  icon: const Icon(Icons.self_improvement),
                  label: Text('Enter Sacred Silence (${widget.prompt.suggestedSilence.inMinutes} min)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[100],
                    foregroundColor: Colors.indigo[800],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            const Text(
              'What arises for you?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            const SizedBox(height: 8),
            
            TextField(
              controller: _reflectionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Let your reflection flow naturally...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.allowSkip)
                  TextButton(
                    onPressed: () => widget.onReflection('skipped'),
                    child: const Text('Not ready for this depth'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    final reflection = _reflectionController.text.trim();
                    if (reflection.isNotEmpty) {
                      widget.onReflection(reflection);
                    }
                  },
                  child: const Text('Share Reflection'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSilenceSpace() {
    return Card(
      color: Colors.black87,
      margin: const EdgeInsets.all(16),
      child: Container(
        height: 300,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _breathAnimation,
                builder: (context, child) => Transform.scale(
                  scale: _breathAnimation.value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '•',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => setState(() => _inSilence = false),
                child: const Text(
                  'Return to reflection',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExistentialPresenceWidget extends StatefulWidget {
  final String userExpression;
  final Duration silenceDuration;
  
  const ExistentialPresenceWidget({
    required this.userExpression,
    required this.silenceDuration,
    super.key,
  });

  @override
  State<ExistentialPresenceWidget> createState() => _ExistentialPresenceWidgetState();
}

class _ExistentialPresenceWidgetState extends State<ExistentialPresenceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _presenceController;
  late Animation<double> _presenceAnimation;

  @override
  void initState() {
    super.initState();
    _presenceController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _presenceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _presenceController, curve: Curves.easeInOut),
    );
    _presenceController.forward();
  }

  @override
  void dispose() {
    _presenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _presenceAnimation,
      child: Card(
        color: Colors.purple[50],
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.purple[300],
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text(
                'I hear you.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'I\'m sitting with you in this truth. You don\'t need to carry it alone.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.userExpression,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
