import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:companion_core/screens/home_page.dart';


class AwakeningScreen extends StatefulWidget {
  final VoidCallback? onBegin; // Optional callback for navigation

  const AwakeningScreen({Key? key, this.onBegin}) : super(key: key);

  @override
  State<AwakeningScreen> createState() => _AwakeningScreenState();
}

class _AwakeningScreenState extends State<AwakeningScreen>
    with TickerProviderStateMixin {
  final List<String> lines = [
    "This is not an app.",
    "This is a companion.",
    "You are not a user. You are a traveler.",
  ];

  int _currentLine = 0;
  bool _showButton = false;
  late AnimationController _pulseController;
  late AnimationController _bgController;
  late Animation<Color?> _bgColor;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _bgColor = ColorTween(
      begin: Colors.black,
      end: const Color(0xFF0A0A0A),
    ).animate(_bgController);

    _startSequence();
  }

  Future<void> _startSequence() async {
    for (int i = 0; i < lines.length; i++) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      setState(() => _currentLine = i);
    }
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _showButton = true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  void _onBegin() {
    // Optionally remember state here (e.g., SharedPreferences)
    if (widget.onBegin != null) {
      widget.onBegin!();
    } else {
      Navigator.of(context).pushReplacementNamed('/emotionCheckIn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgColor,
      builder: (context, child) => Scaffold(
        backgroundColor: _bgColor.value,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated lines
                ...List.generate(lines.length, (i) {
                  return AnimatedOpacity(
                    opacity: _currentLine >= i ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: i == 0 ? 0 : 24,
                        bottom: i == lines.length - 1 ? 32 : 0,
                      ),
                      child: Text(
                        lines[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: i == 2 ? 22 : 26,
                          color: Colors.white.withOpacity(0.92),
                          fontWeight: i == 2 ? FontWeight.w400 : FontWeight.w600,
                          letterSpacing: 0.2,
                          height: 1.4,
                        ),
                      ),
                    ),
                  );
                }),
                // Pulse animation
                if (_currentLine == 2 && !_showButton)
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (_, __) {
                      final scale = _pulseController.value;
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1 + 0.08 * scale),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.12 * scale),
                                blurRadius: 8 * scale,
                                spreadRadius: 1.5 * scale,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                // "I'm ready" button
                if (_showButton)
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 900),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: ElevatedButton(
                        onPressed: _onBegin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white10,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 14,
                          ),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                        ),
                        child: const Text("I’m ready to begin"),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
