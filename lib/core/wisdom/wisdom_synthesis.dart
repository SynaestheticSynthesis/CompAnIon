/// Wisdom Synthesis - Learning from the user's own insights
/// This isn't about AI wisdom, but about recognizing and reflecting back
/// the user's own wisdom at moments when they need to remember it most

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WisdomPearl {
  final String insight;
  final String context;
  final DateTime discoveredAt;
  final List<String> relatedEmotions;
  final int resonanceScore; // How much this insight helped them
  
  WisdomPearl({
    required this.insight,
    required this.context,
    required this.discoveredAt,
    required this.relatedEmotions,
    this.resonanceScore = 5,
  });

  Map<String, dynamic> toJson() => {
    'insight': insight,
    'context': context,
    'discoveredAt': discoveredAt.toIso8601String(),
    'relatedEmotions': relatedEmotions,
    'resonanceScore': resonanceScore,
  };

  static WisdomPearl fromJson(Map<String, dynamic> json) => WisdomPearl(
    insight: json['insight'],
    context: json['context'],
    discoveredAt: DateTime.parse(json['discoveredAt']),
    relatedEmotions: List<String>.from(json['relatedEmotions']),
    resonanceScore: json['resonanceScore'] ?? 5,
  );
}

class WisdomSynthesis {
  static const String _wisdomKey = 'user_wisdom_pearls';
  
  /// Analyzes user's reflections to extract wisdom pearls
  static List<String> extractWisdomFromReflection(String reflection) {
    final wisdomIndicators = [
      RegExp(r'i (?:learned|realized|discovered|understand now)', caseSensitive: false),
      RegExp(r'what (?:helps|works) is', caseSensitive: false),
      RegExp(r'i need to (?:remember|trust)', caseSensitive: false),
      RegExp(r'the truth is', caseSensitive: false),
      RegExp(r'what matters most', caseSensitive: false),
    ];
    
    List<String> extractedWisdom = [];
    
    for (var indicator in wisdomIndicators) {
      final matches = indicator.allMatches(reflection);
      for (var match in matches) {
        // Extract the sentence containing the wisdom
        final sentence = _extractSentence(reflection, match.start);
        if (sentence.length > 20 && sentence.length < 200) {
          extractedWisdom.add(sentence);
        }
      }
    }
    
    return extractedWisdom;
  }
  
  static String _extractSentence(String text, int position) {
    int start = text.lastIndexOf('.', position) + 1;
    int end = text.indexOf('.', position);
    if (end == -1) end = text.length;
    return text.substring(start, end).trim();
  }
  
  /// Saves a wisdom pearl discovered by the user
  static Future<void> saveWisdomPearl(WisdomPearl pearl) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadWisdomPearls();
    existing.add(pearl);
    
    final jsonList = existing.map((p) => p.toJson()).toList();
    await prefs.setString(_wisdomKey, jsonEncode(jsonList));
  }
  
  /// Loads all user's wisdom pearls
  static Future<List<WisdomPearl>> loadWisdomPearls() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_wisdomKey);
    if (jsonStr == null) return [];
    
    final List<dynamic> jsonList = jsonDecode(jsonStr);
    return jsonList.map((json) => WisdomPearl.fromJson(json)).toList();
  }
  
  /// Finds relevant wisdom pearl for current emotional state
  static Future<WisdomPearl?> findRelevantWisdom({
    required String currentEmotion,
    required String currentContext,
  }) async {
    final pearls = await loadWisdomPearls();
    
    // Find pearls with similar emotional context
    final relevant = pearls.where((pearl) =>
      pearl.relatedEmotions.any((emotion) =>
        emotion.toLowerCase().contains(currentEmotion.toLowerCase())
      ) ||
      pearl.context.toLowerCase().contains(currentContext.toLowerCase())
    ).toList();
    
    if (relevant.isEmpty) return null;
    
    // Return the highest resonance score
    relevant.sort((a, b) => b.resonanceScore.compareTo(a.resonanceScore));
    return relevant.first;
  }
  
  /// Creates a widget to display user's own wisdom back to them
  static Widget createWisdomReflection({
    required WisdomPearl pearl,
    required Function(int) onResonanceUpdate,
  }) {
    return WisdomReflectionWidget(
      pearl: pearl,
      onResonanceUpdate: onResonanceUpdate,
    );
  }
  
  /// Analyzes patterns in user's wisdom to identify core themes
  static Future<List<String>> identifyWisdomThemes() async {
    final pearls = await loadWisdomPearls();
    if (pearls.length < 3) return [];
    
    Map<String, int> themeCount = {};
    
    for (var pearl in pearls) {
      final words = pearl.insight.toLowerCase().split(' ');
      for (var word in words) {
        if (word.length > 4 && !_isStopWord(word)) {
          themeCount[word] = (themeCount[word] ?? 0) + 1;
        }
      }
    }
    
    final themes = themeCount.entries
        .where((entry) => entry.value >= 2)
        .map((entry) => entry.key)
        .toList();
    
    themes.sort((a, b) => themeCount[b]!.compareTo(themeCount[a]!));
    return themes.take(5).toList();
  }
  
  static bool _isStopWord(String word) {
    final stopWords = ['need', 'that', 'have', 'this', 'with', 'from', 'they', 'been', 'have', 'their'];
    return stopWords.contains(word);
  }
}

class WisdomReflectionWidget extends StatefulWidget {
  final WisdomPearl pearl;
  final Function(int) onResonanceUpdate;
  
  const WisdomReflectionWidget({
    required this.pearl,
    required this.onResonanceUpdate,
    super.key,
  });

  @override
  State<WisdomReflectionWidget> createState() => _WisdomReflectionWidgetState();
}

class _WisdomReflectionWidgetState extends State<WisdomReflectionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeSince = DateTime.now().difference(widget.pearl.discoveredAt).inDays;
    
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(_glowAnimation.value * 0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Card(
          color: Colors.amber[50],
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.diamond,
                      color: Colors.amber[600],
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Your Own Wisdom',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$timeSince days ago',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber[200]!),
                  ),
                  child: Text(
                    widget.pearl.insight,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                Text(
                  'Context: ${widget.pearl.context}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                const Text(
                  'Does this still resonate with you?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                
                const SizedBox(height: 8),
                
                Row(
                  children: [
                    ...List.generate(5, (index) => GestureDetector(
                      onTap: () => widget.onResonanceUpdate(index + 1),
                      child: Icon(
                        Icons.star,
                        color: index < widget.pearl.resonanceScore
                            ? Colors.amber[600]
                            : Colors.grey[300],
                        size: 32,
                      ),
                    )),
                    const SizedBox(width: 16),
                    Text('${widget.pearl.resonanceScore}/5'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
