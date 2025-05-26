import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/dialogue_engine.dart';
import '../dialogues/acceptance_dialogues.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final engine = Provider.of<DialogueEngine>(context);

    return Scaffold(
      appBar: AppBar(title: Text('CompAnIon')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: engine.messages.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(engine.messages[index]));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Ενεργοποίησε Διάλογο'),
              onPressed: () {
                engine.startDialogue(acceptanceDialogue);
              },
            ),
          )
        ],
      ),
    );
  }
}
