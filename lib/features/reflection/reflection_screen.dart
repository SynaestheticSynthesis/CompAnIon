import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ReflectionScreen
/// Εμφανίζει ερωτήσεις αυτογνωσίας μετά το check-in και αποθηκεύει τις απαντήσεις.
class ReflectionScreen extends StatefulWidget {
  final String emotion;
  final String timestamp;
  final String comment;
  final void Function(List<String> answers) onComplete;

  const ReflectionScreen({
    Key? key,
    required this.emotion,
    required this.timestamp,
    required this.comment,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen> with SingleTickerProviderStateMixin {
  // Ερωτήσεις αυτογνωσίας
  final List<String> _questions = [
    'Τι σε έκανε να νιώσεις έτσι;',
    'Τι θα ήθελες να αλλάξει ή να παραμείνει το ίδιο;',
    'Τι μπορείς να κάνεις για να φροντίσεις τον εαυτό σου σήμερα;'
  ];

  // Απαντήσεις χρήστη
  late List<TextEditingController> _controllers;
  int _currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  static const String _draftKey = 'reflectionDraft';

  // Branching follow-up questions based on emotion or answer
  String? _followUp;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_questions.length, (_) => TextEditingController());
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
    _loadDraft();
  }

  // Αυτόματη αποθήκευση κάθε φορά που αλλάζει απάντηση
  void _onAnswerChanged(int i, String value) {
    _saveDraft();
  }

  // Αποθήκευση draft στο shared_preferences
  Future<void> _saveDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final answers = _controllers.map((c) => c.text).toList();
    final draft = <String, dynamic>{
      'emotion': widget.emotion,
      'timestamp': widget.timestamp,
      'comment': widget.comment,
      'answers': answers,
      'currentIndex': _currentIndex,
    };
    await prefs.setString(_draftKey, draft.toString());
  }

  // Φόρτωση draft αν υπάρχει
  Future<void> _loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_draftKey);
    if (raw != null && raw.contains(widget.emotion) && raw.contains(widget.timestamp)) {
      // Απλή αποσυμπίεση (για demo, μπορεί να γίνει με json για robustness)
      final parts = raw.split("'answers': [");
      if (parts.length > 1) {
        final answersPart = parts[1].split(']')[0];
        final answers = answersPart.split(',').map((s) => s.trim().replaceAll("'", "")).toList();
        for (int i = 0; i < answers.length && i < _controllers.length; i++) {
          _controllers[i].text = answers[i];
        }
      }
      if (raw.contains("'currentIndex': ")) {
        final idx = int.tryParse(raw.split("'currentIndex': ")[1].split(',')[0]);
        if (idx != null && idx >= 0 && idx < _questions.length) {
          setState(() {
            _currentIndex = idx;
          });
        }
      }
    }
  }

  // Καθαρισμός draft όταν ολοκληρωθεί
  Future<void> _clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftKey);
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _fadeController.reverse().then((_) {
        setState(() {
          _currentIndex++;
        });
        _fadeController.forward();
        _saveDraft();
      });
    } else {
      // Branching: show follow-up if needed
      final lastAnswer = _controllers.last.text.trim().toLowerCase();
      final negative = ['sad', 'disappointed', 'angry', 'anxious'];
      final positive = ['happy', 'excited', 'grateful', 'joy'];
      if (_followUp == null) {
        if (negative.any((e) => widget.emotion.toLowerCase().contains(e)) ||
            lastAnswer.contains('δεν') ||
            lastAnswer.contains('δύσκολο') ||
            lastAnswer.contains('στεναχωρ')) {
          setState(() {
            _followUp = 'Είναι δύσκολο να νιώθεις έτσι. Θέλεις να γράψεις τι θα σε βοηθούσε να νιώσεις καλύτερα ή να ζητήσεις υποστήριξη;';
          });
          return;
        } else if (positive.any((e) => widget.emotion.toLowerCase().contains(e)) ||
            lastAnswer.contains('χαρά') ||
            lastAnswer.contains('ευγνωμοσύνη')) {
          setState(() {
            _followUp = 'Τι σε κάνει να νιώθεις ευγνωμοσύνη αυτή τη στιγμή;';
          });
          return;
        }
      }
      _submit();
    }
  }

  void _submit() {
    final answers = _controllers.map((c) => c.text.trim()).toList();
    if (_followUp != null) {
      answers.add(_followUpAnswer.text.trim());
    }
    _clearDraft();
    widget.onComplete(answers);
  }

  final TextEditingController _followUpAnswer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final total = _questions.length;
    final progress = (_currentIndex + 1) / total;
    return Scaffold(
      appBar: AppBar(title: const Text('Reflection')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Συναίσθημα: ${widget.emotion}', style: const TextStyle(fontSize: 18)),
            Text('Σχόλιο: ${widget.comment}', style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            const SizedBox(height: 16),
            // Animated progress bar
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 400),
              builder: (context, value, child) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _followUp == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_questions[_currentIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _controllers[_currentIndex],
                            minLines: 2,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Η απάντησή σου...'
                            ),
                            onChanged: (val) => _onAnswerChanged(_currentIndex, val),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_followUp!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _followUpAnswer,
                            minLines: 2,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Η απάντησή σου...'
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex > 0 && _followUp == null)
                  TextButton(
                    onPressed: _prevQuestion,
                    child: const Text('Προηγούμενο'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_followUp == null) {
                      if (_controllers[_currentIndex].text.trim().isNotEmpty) {
                        _nextQuestion();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Συμπλήρωσε την απάντηση για να συνεχίσεις.')),
                        );
                      }
                    } else {
                      if (_followUpAnswer.text.trim().isNotEmpty) {
                        _submit();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Συμπλήρωσε την απάντηση για να συνεχίσεις.')),
                        );
                      }
                    }
                  },
                  child: Text(
                    _followUp == null
                        ? (_currentIndex == _questions.length - 1 ? 'Επόμενο' : 'Επόμενο')
                        : 'Αποθήκευση Reflection',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}