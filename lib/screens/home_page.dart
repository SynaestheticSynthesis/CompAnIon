import 'package:flutter/material.dart';
import 'package:companion_core/widgets/presence_pulse.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // TODO: Add animated background later
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
