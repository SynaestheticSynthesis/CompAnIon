import 'package:flutter/material.dart';

enum PresenceMode {
  silent,      // Μόνο όταν ζητηθεί
  gentle,      // Διακριτικές υπενθυμίσεις
  active,      // Συχνή, ενεργή παρουσία
}

class PresenceModeProvider extends ChangeNotifier {
  PresenceMode _mode = PresenceMode.gentle;

  PresenceMode get mode => _mode;

  void setMode(PresenceMode mode) {
    _mode = mode;
    notifyListeners();
  }
}
