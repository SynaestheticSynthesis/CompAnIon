import 'package:flutter/material.dart';

class PresencePulse extends StatefulWidget {
  final VoidCallback onTap;

  const PresencePulse({super.key, required this.onTap});

  @override
  State<PresencePulse> createState() => _PresencePulseState();
}

class _PresencePulseState extends State<PresencePulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.blue.shade300, Colors.transparent],
              center: Alignment.center,
              radius: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.6),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              '☁️',
              style: TextStyle(fontSize: 40, color: Colors.white70),
            ),
          ),
        ),
      ),
    );
  }
}
