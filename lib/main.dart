import 'package:flutter/material.dart';
import 'engine/companion_engine.dart';
import 'core/mock_input.dart';
import 'core/emotional_state.dart';

void main() {
  runApp(CompanionApp());
}

class CompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CompAnIon',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: CompanionHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CompanionHomePage extends StatefulWidget {
  @override
  _CompanionHomePageState createState() => _CompanionHomePageState();
}

class _CompanionHomePageState extends State<CompanionHomePage> {
  final engine = CompanionEngine();

  String emotionalStatus = '';
  List<String> logs = [];

  void simulateCompanion() {
    final input = MockInput.generateRandom();
    final response = engine.process(input);

    setState(() {
      emotionalStatus = input.toString();
      logs.add(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CompAnIon Simulator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: simulateCompanion,
              child: Text('Simulate Emotional Input'),
            ),
            SizedBox(height: 16),
            Text(
              'Current Emotional Input:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(emotionalStatus),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.bolt),
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
