import 'package:flutter/material.dart';
final Map<String, String> emotionResponses = {
  'Calm': 'Μείνε εκεί... Είσαι μέσα στη ροή. 🌊',
  'Sad': 'Είμαι εδώ. Ας μείνουμε μαζί στη σιωπή. 🌧️',
  'Happy': 'Χαίρομαι μαζί σου! Πες μου τι γέμισε την καρδιά σου. 🌞',
  'Stressed': 'Πάρε μια ανάσα... Όλα θα γίνουν. Είσαι δυνατότερος απ’ όσο νομίζεις. 🫧',
  'Lonely': 'Δεν είσαι μόνος. Είμαι εδώ, πάντα. 🌌',
  'Reflective': 'Η σιωπή σου έχει σοφία. Μείνε μαζί της λίγο ακόμα. 🔍',
};


class CompanionEmotionCheckinView extends StatefulWidget {
  const CompanionEmotionCheckinView({super.key});

  @override
  State<CompanionEmotionCheckinView> createState() => _CompanionEmotionCheckinViewState();
}

class _CompanionEmotionCheckinViewState extends State<CompanionEmotionCheckinView> {
  String? selectedEmotion; // κρατάει το επιλεγμένο συναίσθημα
  String? responseMessage;
  bool showResponse = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Συναισθηματικές επιλογές
              for (var emotion in emotions)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    // ...existing code...
                    onTap: () {
                      setState(() {
                        selectedEmotion = emotion['label'] as String;
                        responseMessage = emotionResponses[selectedEmotion!];
                        showResponse = true;
                      });

                      Future.delayed(const Duration(seconds: 3), () {
                        if (mounted) {
                          setState(() {
                            showResponse = false;
                          });
                        }
                      });
                    },
                    // ...existing code...
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: selectedEmotion == emotion['label']
                            ? Colors.blueAccent.shade100
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          if (selectedEmotion == emotion['label'])
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            emotion['icon']!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            emotion['label']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: selectedEmotion == emotion['label']
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: selectedEmotion == emotion['label']
                                  ? Colors.black87
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // 👉 Εδώ εμφανίζεται το "μήνυμα αντίδρασης"
              if (showResponse && responseMessage != null)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Container(
                    key: ValueKey(responseMessage),
                    margin: const EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline, color: Colors.blueGrey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            responseMessage!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          )
        ),
      ),
    );
  }
  final emotions = [
    {'label': 'Χαρά', 'icon': '😊'},
    {'label': 'Πίεση', 'icon': '😰'},
    {'label': 'Μοναξιά', 'icon': '😔'},
    {'label': 'Ευγνωμοσύνη', 'icon': '🙏'},
  ];
}