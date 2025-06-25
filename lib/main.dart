import 'package:flutter/material.dart';
import 'engine/companion_engine.dart';
import 'core/mock_input.dart';
import 'core/emotional_state.dart';

void main() {
  runApp(const CompanionApp());
}

class CompanionApp extends StatelessWidget {
  const CompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CompAnIon',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const CompanionHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CompanionHomePage extends StatefulWidget {
  const CompanionHomePage({super.key});

  @override
  State<CompanionHomePage> createState() => _CompanionHomePageState();
}

class _CompanionHomePageState extends State<CompanionHomePage> {
  final engine = CompanionEngine();

  String emotionalStatus = '';
  List<String> logs = [];
  String? errorMessage;

  final TextEditingController _customInputController = TextEditingController();

  @override
  void dispose() {
    _customInputController.dispose();
    super.dispose();
  }

  void simulateCompanion({String? customInput}) {
    try {
      final input = customInput != null && customInput.trim().isNotEmpty
          ? MockInput.fromText(customInput)
          : MockInput.generateRandom();
      final response = engine.process(input);

      setState(() {
        emotionalStatus = input.toString();
        logs.add(response);
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Σφάλμα: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CompAnIon Simulator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customInputController,
                    decoration: const InputDecoration(
                      labelText: 'Custom Emotional Input',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => simulateCompanion(
                    customInput: _customInputController.text,
                  ),
                  child: const Text('Send'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => simulateCompanion(),
              child: const Text('Simulate Random Emotional Input'),
            ),
            const SizedBox(height: 16),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 8),
            const Text(
              'Current Emotional Input:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(emotionalStatus),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.bolt),
                  title: Text(logs[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
