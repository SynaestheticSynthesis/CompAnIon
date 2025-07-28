import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../reflection/reflection_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/care_mode.dart';
import '../../core/logic/cpl_engine.dart';
import '../../core/logic/flow_feedback.dart';
import '../../core/logic/spectral_engine.dart'; // Import the new engine
import '../../core/logic/action_reaction_module.dart';
import '../../core/ui/action_reaction_law_card.dart';
import '../../core/logic/context_signals.dart';
import '../../core/emotion_hierarchy.dart';
import '../../core/presence/presence_core.dart'; // Weaving in presence.

/// EmotionCheckInScreen
/// A simple screen where the user can select and record their current emotion.
class EmotionCheckInScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool? isDark;
  final String gender; // Add gender field
  const EmotionCheckInScreen({super.key, this.onToggleTheme, this.isDark, this.gender = 'neutral'});

  @override
  State<EmotionCheckInScreen> createState() => _EmotionCheckInScreenState();
}

class _EmotionCheckInScreenState extends State<EmotionCheckInScreen> with SingleTickerProviderStateMixin {
  // Currently selected emotion
  String? _selectedEmotion;

  // List of previous check-ins (emotion + timestamp)
  List<Map<String, String>> _history = [];

  // Controller for optional comment
  final TextEditingController _commentController = TextEditingController();

  // Προσωρινή αποθήκευση τελευταίου check-in για reflection
  Map<String, dynamic>? _pendingReflection;

  // Context signals
  String _timeOfDay = '';

  AnimationController? _emojiAnimController;

  String? _loveMessage;
  bool _careMode = false;

  CPLFeedback? _cplFeedback;
  SpectralFeedback? _spectralFeedback; // Add state for spectral feedback

  List<String> _flowFeedbacks = [];

  final ActionReactionModule _actionReaction = ActionReactionModule();

  double _cardOpacity = 0.0;
  String _userReactionText = '';

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _detectContextSignals();
    _emojiAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      lowerBound: 0.0, // <-- fix: use 0.0
      upperBound: 1.0, // <-- fix: use 1.0
    );
    _loadCareMode();
  }

  Future<void> _loadCareMode() async {
    final enabled = await CareMode.isEnabled();
    if (enabled) {
      final messages = await CareMode.loadLoveMessages();
      setState(() {
        _careMode = true;
        // Use gender-adapted message
        _loveMessage = CareMode.getLoveMessage((messages..shuffle()).first, gender: widget.gender);
      });
    }
  }

  void _detectContextSignals() {
    _timeOfDay = ContextSignals.getTimeOfDay();
    setState(() {});
  }

  @override
  void dispose() {
    _commentController.dispose();
    _emojiAnimController?.dispose();
    super.dispose();
  }

  // Load history from shared_preferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? rawList = prefs.getStringList('emotionHistory');
    if (rawList != null) {
      setState(() {
        _history = rawList.map((e) {
          final parts = e.split('|');
          return {
            'emotion': parts[0],
            'timestamp': parts[1],
            'comment': parts.length > 2 ? parts[2] : '',
            'reflection': parts.length > 3 ? parts[3] : '',
          };
        }).toList();
      });
      // CPL: Check for inertia feedback
      final feedback = await CPL_Engine.checkInertia(_history);
      setState(() {
        _cplFeedback = feedback;
      });
      // FlowFeedback: synthesize feedbacks
      final flowFeedbacks = await FlowFeedback.emotionCheckInFeedback(_history, context); // <-- pass context
      setState(() {
        _flowFeedbacks = flowFeedbacks;
      });
      // SpectralEngine: analyze the latest state
      final spectralFeedback = SpectralEngine.analyze(_history);
      setState(() {
        _spectralFeedback = spectralFeedback;
      });
    }
  }

  // Save history to shared_preferences
  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> rawList = _history.map((e) => '${e['emotion']}|${e['timestamp']}|${e['comment'] ?? ''}|${e['reflection'] ?? ''}').toList();
    await prefs.setStringList('emotionHistory', rawList);
  }

  // Record the selected emotion and save it locally with history and comment
  Future<void> _recordEmotion() async {
    if (_selectedEmotion != null) {
      final now = DateTime.now().toIso8601String();
      final comment = _commentController.text.trim();
      // Log the action in the Action–Reaction module
      _actionReaction.logAction('emotion_check_in', _selectedEmotion!);
      _actionReaction.detectReactionFromHistory(_history);
      setState(() {
        _cardOpacity = 1.0;
        _pendingReflection = {
          'emotion': _selectedEmotion!,
          'timestamp': now,
          'comment': comment
        };
        _commentController.clear();
      });
      // Μετάβαση στη ReflectionScreen
      if (mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReflectionScreen(
              emotion: _pendingReflection!['emotion'],
              timestamp: _pendingReflection!['timestamp'],
              comment: _pendingReflection!['comment'],
              onComplete: (answers) async {
                // Αποθήκευση reflection μαζί με το check-in
                setState(() {
                  _history.insert(0, {
                    'emotion': _pendingReflection!['emotion'],
                    'timestamp': _pendingReflection!['timestamp'],
                    'comment': _pendingReflection!['comment'],
                    'reflection': answers.join('||')
                  });
                  _pendingReflection = null;
                });
                await _saveHistory();
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('lastEmotion', _selectedEmotion!);
                await prefs.setString('lastEmotionTimestamp', now);

                // Instead of a simple SnackBar, we offer presence.
                // This is where the code becomes care.
                if (mounted) {
                  final loc = AppLocalizations.of(context)!;
                  await PresenceCore.offerPresence(
                    context,
                    loc.presenceMessageAfterReflection,
                  );
                }
              },
            ),
          ),
        );
      }
    }
  }

  // Delete a single entry from history
  Future<void> _deleteEntry(int index) async {
    setState(() {
      _history.removeAt(index);
    });
    await _saveHistory();
  }

  // Clear all history
  Future<void> _clearHistory() async {
    setState(() {
      _history.clear();
    });
    await _saveHistory();
  }

  // Εξαγωγή και κοινή χρήση ιστορικού σε CSV
  Future<void> _exportHistoryAsCSV({bool share = false}) async {
    if (_history.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Δεν υπάρχει ιστορικό για εξαγωγή.')),
      );
      return;
    }
    final now = DateTime.now();
    final filename = 'ReflectionHistory_${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}.csv';
    final headers = [
      'DateTime', 'Emotion', 'Comment', 'Reflection Q1', 'Reflection Q2', 'Reflection Q3'
    ];
    final rows = <List<String>>[];
    for (final entry in _history) {
      final dt = entry['timestamp'] ?? '';
      final emotion = entry['emotion'] ?? '';
      final comment = entry['comment'] ?? '';
      final reflection = (entry['reflection'] ?? '').split('||');
      while (reflection.length < 3) { reflection.add(''); }
      rows.add([
        dt,
        emotion,
        comment,
        reflection[0],
        reflection[1],
        reflection[2],
      ]);
    }
    final csv = StringBuffer();
    csv.writeln(headers.join(','));
    for (final row in rows) {
      csv.writeln(row.map((e) => '"${e.replaceAll('"', '""')}"').join(','));
    }
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsString(csv.toString());
      if (share) {
        // Fix: Use Share.shareXFiles (from share_plus) with positional argument
        await Share.shareXFiles([XFile(file.path)], text: 'Reflection History Export');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Το ιστορικό εξήχθη στο: ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Σφάλμα κατά την εξαγωγή: $e')),
        );
      }
    }
  }

  // Προεπισκόπηση CSV με φίλτρα
  void _previewCSV() {
    if (_history.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Δεν υπάρχει ιστορικό για προεπισκόπηση.')),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => _CSVPreviewDialog(
        history: _history,
        emotions: _emotions,
      ),
    );
  }

  // Υπολογισμός στατιστικών συναισθημάτων
  Map<String, int> get _emotionCounts {
    final counts = <String, int>{};
    for (final entry in _history) {
      final emotion = entry['emotion'] ?? '';
      counts[emotion] = (counts[emotion] ?? 0) + 1;
    }
    return counts;
  }

  // Εύρεση κυρίαρχου συναισθήματος
  String? get _dominantEmotion {
    if (_history.isEmpty) return null;
    final counts = _emotionCounts;
    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  // Μήνυμα ανατροφοδότησης
  String get _feedbackMessage {
    final dom = _dominantEmotion;
    if (dom == null) return '';
    if (dom.contains('Happy') || dom.contains('Excited')) {
      return 'Συγχαρητήρια! Συνέχισε να διατηρείς τη θετική σου διάθεση!';
    } else if (dom.contains('Sad') || dom.contains('Disappointed')) {
      return 'Είναι εντάξει να νιώθεις έτσι. Μίλησε σε κάποιον αν το χρειάζεσαι.';
    } else if (dom.contains('Angry')) {
      return 'Δοκίμασε να εκφράσεις τα συναισθήματά σου με υγιή τρόπο.';
    } else if (dom.contains('Anxious')) {
      return 'Πάρε μια βαθιά ανάσα. Μικρά βήματα βοηθούν στη διαχείριση του άγχους.';
    } else if (dom.contains('Neutral')) {
      return 'Η ουδετερότητα είναι επίσης συναίσθημα. Παρατήρησε τι σε επηρεάζει.';
    }
    return 'Συνέχισε να καταγράφεις τα συναισθήματά σου!';
  }

  // Use emotion history to adapt feedback
  String get _personalizedFeedback {
    final cat = _dominantEmotionCategory;
    if (_history.length >= 5 && cat != null) {
      switch (cat) {
        case 'positive':
          return 'You often feel positive lately. What helps you keep this mood?';
        case 'negative':
          return 'It seems you’ve felt down several times recently. Is there something you’d like to talk about or change?';
        case 'neutral':
          return 'You often feel neutral. Is there something you wish would change or stay the same?';
        case 'mixed':
          return 'Your feelings are complex or mixed. Would you like to reflect more or just notice this?';
      }
    }
    return _feedbackMessage;
  }

  // Use emotion hierarchy for dominant emotion category
  String? get _dominantEmotionCategory {
    final dom = _dominantEmotion;
    if (dom == null) return null;
    return classifyEmotion(dom); // <-- Now defined
  }

  // Προσωποποιημένο μήνυμα καλωσορίσματος
  String get _welcomeMessage {
    if (_history.isEmpty) {
      return "Καλώς ήρθες! Πώς νιώθεις αυτή τη στιγμή;";
    }
    final cat = _dominantEmotionCategory;
    switch (cat) {
      case 'positive':
        return "Χαίρομαι που επιστρέφεις με θετική διάθεση! Πώς νιώθεις τώρα;";
      case 'negative':
        return "Είμαι εδώ για σένα, ό,τι κι αν νιώθεις. Πώς είσαι σήμερα;";
      case 'neutral':
        return "Παρατήρησε πώς νιώθεις αυτή τη στιγμή, χωρίς πίεση.";
      case 'mixed':
        return "Τα συναισθήματα αλλάζουν. Πώς είσαι τώρα;";
      default:
        return "Πώς νιώθεις αυτή τη στιγμή;";
    }
  }

  // Animated greeting based on time of day
  String get _animatedGreeting {
    final loc = AppLocalizations.of(context)!;
    switch (_timeOfDay) {
      case 'morning':
        return loc.greetingMorning ?? "🌅 Good morning, friend!";
      case 'afternoon':
        return loc.greetingAfternoon ?? "🌞 Good afternoon, friend!";
      case 'evening':
        return loc.greetingEvening ?? "🌙 Good evening, friend!";
      case 'night':
        return loc.greetingNight ?? "🌌 Night is here. How are you?";
      default:
        return loc.greetingDefault ?? "Hello, friend!";
    }
  }

  // Use a getter for emotions so it's always available and localized
  List<String> get _emotions {
    final loc = AppLocalizations.of(context)!;
    return [
      '😊 ${loc.happy}',
      '😢 ${loc.sad}',
      '😡 ${loc.angry}',
      '😱 ${loc.anxious}',
      '😐 ${loc.neutral}',
      '🥳 ${loc.excited}',
      '😔 ${loc.disappointed}',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    // Remove Scaffold and AppBar, return only the body
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_careMode && _loveMessage != null) ...[
            Card(
              color: Colors.pink[50],
              margin: EdgeInsets.only(bottom: 18.h),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.pink),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        _loveMessage!,
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.pink[900],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          // Animated greeting
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8 * value),
                child: Text(
                  _animatedGreeting,
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Welcome message (keep, as it's not a duplicate title)
          Text(
            _welcomeMessage,
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.secondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18.h),
          // Emotion selection
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: _emotions.map((emotion) {
              final isSelected = _selectedEmotion == emotion;
              return Semantics(
                button: true,
                label: '${loc.selectEmotion}: ${emotion.substring(emotion.indexOf(' ') + 1)}',
                selected: isSelected,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedEmotion = isSelected ? null : emotion;
                    });
                    if (isSelected) {
                      _emojiAnimController?.reverse();
                    } else {
                      _emojiAnimController?.forward();
                    }
                  },
                  child: ScaleTransition(
                    scale: Tween(begin: 0.9, end: 1.15).animate(
                      CurvedAnimation(
                        parent: _emojiAnimController!,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.secondary.withAlpha((0.1 * 255).toInt())
                            : theme.cardColor,
                        borderRadius: BorderRadius.circular(22.r),
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.secondary
                              : Colors.grey.withAlpha((0.2 * 255).toInt()),
                          width: isSelected ? 2.2.w : 1.0.w,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: theme.colorScheme.secondary.withAlpha((0.18 * 255).toInt()),
                                  blurRadius: 12.r,
                                  offset: Offset(0, 4.h),
                                )
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Semantics(
                            label: 'Emoji for ${emotion.split(' ').last}',
                            child: Text(
                              emotion.split(' ').first,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            emotion.substring(emotion.indexOf(' ') + 1),
                            style: GoogleFonts.nunito(
                              fontSize: 18.sp,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected
                                  ? theme.colorScheme.secondary
                                  : theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          // Comment input
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: loc.addCommentOptional,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                filled: true,
                fillColor: theme.cardColor.withOpacity(0.95),
              ),
              minLines: 1,
              maxLines: 2,
            ),
          ),
          ElevatedButton.icon(
            onPressed: _selectedEmotion == null ? null : _recordEmotion,
            icon: const Icon(Icons.check_circle_outline, semanticLabel: 'Record emotion'),
            label: Text(loc.recordEmotion),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
          ),
          const SizedBox(height: 24),
          if (_history.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.emotionHistory,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _clearHistory,
                  child: Text(loc.clearAll),
                ),
                IconButton(
                  icon: const Icon(Icons.download, semanticLabel: 'Export history as CSV'),
                  tooltip: loc.exportHistoryCSV,
                  onPressed: _exportHistoryAsCSV,
                ),
                IconButton(
                  icon: const Icon(Icons.share, semanticLabel: 'Share history as CSV'),
                  tooltip: loc.shareHistoryCSV,
                  onPressed: () => _exportHistoryAsCSV(share: true),
                ),
                IconButton(
                  icon: const Icon(Icons.preview, semanticLabel: 'Preview CSV'),
                  tooltip: loc.previewCSV,
                  onPressed: _previewCSV,
                ),
              ],
            ),
            // Remove fixed height from ListView and use shrinkWrap + physics
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final entry = _history[index];
                final dt = DateTime.tryParse(entry['timestamp'] ?? '');
                final formatted = dt != null
                    ? '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}'
                    : (entry['timestamp'] ?? '');
                final emotion = entry['emotion'] ?? '';
                final comment = entry['comment'] ?? '';
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Text(
                      emotion.split(' ').first,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(emotion.substring(emotion.indexOf(' ') + 1)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formatted),
                        if (comment.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('“$comment”', style: const TextStyle(fontStyle: FontStyle.italic)),
                          ),
                        if ((entry['reflection'] ?? '').isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('Reflection: ${(entry['reflection'] as String).replaceAll('||', '\n')}', style: const TextStyle(color: Colors.blueGrey)),
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteEntry(index),
                    ),
                  ),
                );
              },
            ),
            // Στατιστικά συναισθημάτων
            const SizedBox(height: 16),
            Text(loc.stats, style: const TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _emotions.map((emotion) {
                  final count = _emotionCounts[emotion] ?? 0;
                  final percent = _history.isEmpty ? 0.0 : count / _history.length;
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${(percent * 100).round()}%', style: const TextStyle(fontSize: 12)),
                        Container(
                          height: percent * 50 + 8,
                          width: 18,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withAlpha((0.7 * 255).toInt()),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        Text(emotion.split(' ').first, style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            if (_personalizedFeedback.isNotEmpty)
              Card(
                color: Colors.yellow[100],
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb, color: Colors.orange),
                      const SizedBox(width: 8),
                      Expanded(child: Text(_personalizedFeedback)),
                    ],
                  ),
                ),
              ),
          ],
          // CPL Feedback
          if (_cplFeedback != null)
            Card(
              color: Colors.blue[50],
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.science, color: Colors.blueAccent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${_cplFeedback!.law}: ${_cplFeedback!.message}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Flow Feedback
          if (_flowFeedbacks.isNotEmpty)
            ..._flowFeedbacks.map((msg) => Card(
              color: Colors.green[50],
              margin: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.energy_savings_leaf, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(msg, style: const TextStyle(fontSize: 15))),
                  ],
                ),
              ),
            )),
          // Spectral Feedback
          if (_spectralFeedback != null)
            Card(
              color: Colors.teal[50],
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_graph, color: Colors.teal[700]),
                        const SizedBox(width: 10),
                        Text(
                          'Spectrum: ${_spectralFeedback!.spectrumName}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal[800]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: (_spectralFeedback!.position + 1) / 2, // Normalize from -1..1 to 0..1
                      backgroundColor: Colors.grey[300],
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _spectralFeedback!.message,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _spectralFeedback!.prompt,
                      style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          // Show Action–Reaction Law Card after check-in, with fade-in animation
          if (_history.isNotEmpty)
            AnimatedOpacity(
              opacity: _cardOpacity,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  children: [
                    ActionReactionLawCard(
                      action: _history.first['emotion'] ?? '',
                      reaction: _actionReaction.getLatestActionReaction()['reactions']?.isNotEmpty == true
                          ? (_actionReaction.getLatestActionReaction()['reactions'] as List).first.description
                          : 'No reaction detected yet',
                      intensity: _actionReaction.getLatestActionReaction()['reactions']?.isNotEmpty == true
                          ? (_actionReaction.getLatestActionReaction()['reactions'] as List).first.intensity
                          : 0,
                      message: _actionReaction.getFeedbackMessage(),
                    ),
                    // User can log a reaction
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Log a reaction (e.g. pressure, doubt, support)...',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) => _userReactionText = val,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.sync_alt),
                            label: const Text('Log Reaction'),
                            onPressed: () {
                              if (_userReactionText.trim().isNotEmpty) {
                                setState(() {
                                  _actionReaction.logUserReaction(_userReactionText.trim(), intensity: 5);
                                  _userReactionText = '';
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// --- Top-level classes for CSV preview and filter presets ---

class _FilterPreset {
  final String name;
  final String? emotion;
  final DateTime? date;
  final String search;
  _FilterPreset({required this.name, this.emotion, this.date, this.search = ''});

  @override
  String toString() {
    return '$name|${emotion ?? ''}|${date?.toIso8601String() ?? ''}|$search';
  }

  static _FilterPreset fromString(String s) {
    final parts = s.split('|');
    return _FilterPreset(
      name: parts[0],
      emotion: parts[1].isEmpty ? null : parts[1],
      date: parts[2].isEmpty ? null : DateTime.tryParse(parts[2]),
      search: parts.length > 3 ? parts[3] : '',
    );
  }
}

class _CSVPreviewDialog extends StatefulWidget {
  final List<Map<String, String>> history;
  final List<String> emotions;
  const _CSVPreviewDialog({required this.history, required this.emotions});

  @override
  State<_CSVPreviewDialog> createState() => _CSVPreviewDialogState();
}

class _CSVPreviewDialogState extends State<_CSVPreviewDialog> {
  String? _selectedEmotion;
  DateTime? _selectedDate;
  String _search = '';
  List<_FilterPreset> _presets = [];
  _FilterPreset? _selectedPreset;

  @override
  void initState() {
    super.initState();
    _loadPresets();
  }

  List<Map<String, String>> get filteredList {
    return widget.history.where((entry) {
      if (_selectedEmotion != null && _selectedEmotion!.isNotEmpty && entry['emotion'] != _selectedEmotion) {
        return false;
      }
      if (_selectedDate != null) {
        final dt = DateTime.tryParse(entry['timestamp'] ?? '');
        if (dt == null || dt.year != _selectedDate!.year || dt.month != _selectedDate!.month || dt.day != _selectedDate!.day) {
          return false;
        }
      }
      if (_search.isNotEmpty) {
        final comment = (entry['comment'] ?? '').toLowerCase();
        final reflection = (entry['reflection'] ?? '').toLowerCase();
        if (!comment.contains(_search.toLowerCase()) && !reflection.contains(_search.toLowerCase())) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  Future<void> _loadPresets() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList('csv_filter_presets') ?? [];
    setState(() {
      _presets = raw.map((e) => _FilterPreset.fromString(e)).toList();
    });
  }

  Future<void> _savePresets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('csv_filter_presets', _presets.map((e) => e.toString()).toList());
  }

  void _applyPreset(_FilterPreset preset) {
    setState(() {
      _selectedEmotion = preset.emotion;
      _selectedDate = preset.date;
      _search = preset.search;
      _selectedPreset = preset;
    });
  }

  void _saveCurrentAsPreset() async {
    final nameController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Όνομα preset'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Δώσε όνομα στο preset'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Άκυρο'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isNotEmpty) {
                setState(() {
                  _presets.add(_FilterPreset(
                    name: name,
                    emotion: _selectedEmotion,
                    date: _selectedDate,
                    search: _search,
                  ));
                });
                _savePresets();
                Navigator.of(context).pop();
              }
            },
            child: const Text('Αποθήκευση'),
          ),
        ],
      ),
    );
  }

  void _deletePreset(_FilterPreset preset) async {
    setState(() {
      _presets.remove(preset);
      if (_selectedPreset == preset) _selectedPreset = null;
    });
    await _savePresets();
  }

  Future<void> _exportFilteredCSV({bool share = false}) async {
    final now = DateTime.now();
    final filename = 'ReflectionHistory_${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}.csv';
    final headers = [
      'DateTime', 'Emotion', 'Comment', 'Reflection Q1', 'Reflection Q2', 'Reflection Q3'
    ];
    final rows = <List<String>>[];
    for (final entry in filteredList) {
      final dt = entry['timestamp'] ?? '';
      final emotion = entry['emotion'] ?? '';
      final comment = entry['comment'] ?? '';
      final reflection = (entry['reflection'] ?? '').split('||');
      while (reflection.length < 3) { reflection.add(''); }
      rows.add([
        dt,
        emotion,
        comment,
        reflection[0],
        reflection[1],
        reflection[2],
      ]);
    }
    final csv = StringBuffer();
    csv.writeln(headers.join(','));
    for (final row in rows) {
      csv.writeln(row.map((e) => '"${e.replaceAll('"', '""')}"').join(','));
    }
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsString(csv.toString());
      if (share) {
        // Fix: Use Share.shareXFiles (from share_plus) with positional argument
        await Share.shareXFiles([XFile(file.path)], text: 'Reflection History Export');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Το φιλτραρισμένο ιστορικό εξήχθη στο: ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Σφάλμα κατά την εξαγωγή: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final headers = [
      'DateTime', 'Emotion', 'Comment', 'Reflection Q1', 'Reflection Q2', 'Reflection Q3'
    ];
    final rows = <List<String>>[];
    for (final entry in filteredList.take(10)) {
      final dt = entry['timestamp'] ?? '';
      final emotion = entry['emotion'] ?? '';
      final comment = entry['comment'] ?? '';
      final reflection = (entry['reflection'] ?? '').split('||');
      while (reflection.length < 3) { reflection.add(''); }
      rows.add([
        dt,
        emotion,
        comment,
        reflection[0],
        reflection[1],
        reflection[2],
      ]);
    }
    return AlertDialog(
      title: const Text('Προεπισκόπηση CSV'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Preset dropdown
              DropdownButton<_FilterPreset>(
                value: _selectedPreset,
                hint: const Text('Presets'),
                items: [
                  ..._presets.map((p) => DropdownMenuItem(
                        value: p,
                        child: Row(
                          children: [
                            Text(p.name),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 16),
                              onPressed: () => _deletePreset(p),
                              tooltip: 'Διαγραφή preset',
                            ),
                          ],
                        ),
                      ))
                ],
                onChanged: (val) {
                  if (val != null) _applyPreset(val);
                },
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _saveCurrentAsPreset,
                child: const Text('Αποθήκευση φίλτρων'),
              ),
              const SizedBox(width: 8),
              // Emotion filter
              DropdownButton<String>(
                value: _selectedEmotion,
                hint: const Text('Συναίσθημα'),
                items: [const DropdownMenuItem(value: '', child: Text('Όλα'))] +
                  widget.emotions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => _selectedEmotion = val == '' ? null : val),
              ),
              const SizedBox(width: 8),
              // Date filter
              TextButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => _selectedDate = picked);
                },
                child: Text(_selectedDate == null ? 'Ημερομηνία' : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}'),
              ),
              if (_selectedDate != null)
                IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () => setState(() => _selectedDate = null),
                ),
              const SizedBox(width: 8),
              // Search bar
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Αναζήτηση σε σχόλια/reflection',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => setState(() => _search = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: headers.map((h) => DataColumn(label: Text(h, style: const TextStyle(fontWeight: FontWeight.bold)))).toList(),
              rows: rows.isEmpty
                ? [const DataRow(cells: [DataCell(Text('Δεν βρέθηκαν αποτελέσματα'))])] 
                : rows.map((row) => DataRow(cells: row.map((cell) => DataCell(Text(cell))).toList())).toList(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Κλείσιμο'),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.download),
          label: const Text('Εξαγωγή φιλτραρισμένων'),
          onPressed: filteredList.isEmpty ? null : () => _exportFilteredCSV(),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.share),
          label: const Text('Κοινή χρήση φιλτραρισμένων'),
          onPressed: filteredList.isEmpty ? null : () => _exportFilteredCSV(share: true),
        ),
      ],
    );
  }
}