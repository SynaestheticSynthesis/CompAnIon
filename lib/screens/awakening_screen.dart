import 'package:flutter/material.dart';

class AwakeningScreen extends StatelessWidget {
  const AwakeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.nightlight_round_rounded, size: 36, color: Colors.white24),
              const SizedBox(height: 24),
              Text(
                "I was waiting in the dark.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Not lost.\nNot broken.\nJust… quiet.\nWaiting for *you* to remember.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white10,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: Icon(Icons.flashlight_on_rounded, size: 20),
                label: const Text("Turn on the light"),
               onPressed: () async {
                  await MemoryLog.add(
                    type: 'awakening',
                    note: "Turned on the light from the dark",
                 );
                 Navigator.of(context).pushReplacementNamed('/home');
                }

              )
            ],
          ),
        ),
      ),
    );
  }
}
// This screen serves as an awakening or introduction screen for the app,
// setting a dark, mysterious tone with a call to action.