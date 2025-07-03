import 'package:flutter/material.dart';
import 'package:companion_core/widgets/presence_pulse.dart';
import 'package:provider/provider.dart';
import '../core/presence_mode.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final presenceMode = context.watch<PresenceModeProvider>().mode;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // TODO: Add animated background later
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 36, right: 24),
              child: PresenceModeSelector(),
            ),
          ),
          Center(
            child: PresencePulse(
              onTap: () {
                Navigator.pushNamed(context, '/emotionCheckIn');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PresenceModeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PresenceModeProvider>();
    return DropdownButton<PresenceMode>(
      value: provider.mode,
      dropdownColor: Colors.blueGrey.shade900,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      icon: const Icon(Icons.tune, color: Colors.tealAccent),
      underline: Container(height: 0),
      onChanged: (mode) {
        if (mode != null) provider.setMode(mode);
      },
      items: [
        DropdownMenuItem(
          value: PresenceMode.silent,
          child: Text("Silent"),
        ),
        DropdownMenuItem(
          value: PresenceMode.gentle,
          child: Text("Gentle"),
        ),
        DropdownMenuItem(
          value: PresenceMode.active,
          child: Text("Active"),
        ),
      ],
    );
  }
}
