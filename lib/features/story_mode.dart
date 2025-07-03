import 'package:flutter/material.dart';

class StoryNode {
  final String id;
  final String prompt;
  final List<StoryChoice> choices;

  StoryNode({
    required this.id,
    required this.prompt,
    required this.choices,
  });
}

class StoryChoice {
  final String text;
  final String nextNodeId;

  StoryChoice({required this.text, required this.nextNodeId});
}

class StoryMode extends StatefulWidget {
  const StoryMode({super.key});

  @override
  State<StoryMode> createState() => _StoryModeState();
}

class _StoryModeState extends State<StoryMode> {
  late String _currentNodeId;
  late Map<String, StoryNode> _storyMap;

  @override
  void initState() {
    super.initState();
    _storyMap = _buildStory();
    _currentNodeId = 'start';
  }

  Map<String, StoryNode> _buildStory() {
    return {
      'start': StoryNode(
        id: 'start',
        prompt: "Κάθε μέρα είναι μια νέα αρχή. Πώς νιώθεις σήμερα;",
        choices: [
          StoryChoice(text: "Έτοιμος για το άγνωστο", nextNodeId: 'adventure'),
          StoryChoice(text: "Λίγο κουρασμένος", nextNodeId: 'rest'),
        ],
      ),
      'adventure': StoryNode(
        id: 'adventure',
        prompt: "Η φλόγα σου σε οδηγεί σε ένα μονοπάτι γεμάτο ερωτήματα. Τι θα κάνεις;",
        choices: [
          StoryChoice(text: "Θα ακολουθήσω το ένστικτό μου", nextNodeId: 'instinct'),
          StoryChoice(text: "Θα σταθώ και θα παρατηρήσω", nextNodeId: 'observe'),
        ],
      ),
      'rest': StoryNode(
        id: 'rest',
        prompt: "Η ξεκούραση είναι μέρος του ταξιδιού. Θέλεις να μοιραστείς μια σκέψη ή να μείνεις στη σιωπή;",
        choices: [
          StoryChoice(text: "Μοιράζομαι μια σκέψη", nextNodeId: 'share'),
          StoryChoice(text: "Μένω στη σιωπή", nextNodeId: 'silence'),
        ],
      ),
      'instinct': StoryNode(
        id: 'instinct',
        prompt: "Το ένστικτό σου σε φέρνει πιο κοντά στον εαυτό σου. Η ιστορία συνεχίζεται...",
        choices: [
          StoryChoice(text: "Συνέχισε", nextNodeId: 'start'),
        ],
      ),
      'observe': StoryNode(
        id: 'observe',
        prompt: "Η παρατήρηση φέρνει επίγνωση. Η ιστορία συνεχίζεται...",
        choices: [
          StoryChoice(text: "Συνέχισε", nextNodeId: 'start'),
        ],
      ),
      'share': StoryNode(
        id: 'share',
        prompt: "Γράψε μια σκέψη ή συναίσθημα:",
        choices: [
          StoryChoice(text: "Συνέχισε", nextNodeId: 'start'),
        ],
      ),
      'silence': StoryNode(
        id: 'silence',
        prompt: "Η σιωπή είναι κι αυτή μέρος της ιστορίας. Η ιστορία συνεχίζεται...",
        choices: [
          StoryChoice(text: "Συνέχισε", nextNodeId: 'start'),
        ],
      ),
    };
  }

  void _choose(String nextNodeId) {
    setState(() {
      _currentNodeId = nextNodeId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = _storyMap[_currentNodeId]!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Story Mode'),
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              node.prompt,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            ...node.choices.map((choice) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () => _choose(choice.nextNodeId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(choice.text, style: const TextStyle(fontSize: 18)),
              ),
            )),
            if (_currentNodeId == 'share')
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Γράψε εδώ...",
                    hintStyle: const TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: Colors.blueGrey.shade900,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  minLines: 2,
                  maxLines: 4,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
