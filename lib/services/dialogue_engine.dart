import 'package:flutter/material.dart';
import '../dialogues/acceptance_dialogues.dart';

class DialogueEngine extends ChangeNotifier {
  final List<String> _messages = [];
  List<String> get messages => _messages;

  Future<void> startDialogue(List<DialogueEntry> dialogue) async {
    _messages.clear();
    notifyListeners();

    for (var entry in dialogue) {
      await Future.delayed(entry.pause);
      _messages.add(entry.text);
      notifyListeners();
    }
  }

  void reset() {
    _messages.clear();
    notifyListeners();
  }
}
