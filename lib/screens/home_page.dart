import 'package:flutter/material.dart';
import 'package:companion_core/widgets/presence_pulse.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text('Debug Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              title: const Text('Emotion Check-In'),
              onTap: () => Navigator.pushNamed(context, '/emotionCheckIn'),
            ),
            ListTile(
              title: const Text('Emotion Reflection'),
              onTap: () => Navigator.pushNamed(context, '/emotionReflection'),
            ),
            ListTile(
              title: const Text('Journal'),
              onTap: () => Navigator.pushNamed(context, '/journal'),
            ),
            ListTile(
              title: const Text('Breathing'),
              onTap: () => Navigator.pushNamed(context, '/breathing'),
            ),
            ListTile(
              title: const Text('Reflective Test'),
              onTap: () => Navigator.pushNamed(context, '/reflective_test'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to CompAnIon!'),
      ),
    );
  }
}
