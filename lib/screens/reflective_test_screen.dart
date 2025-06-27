import 'package:flutter/material.dart';
import '../services/reflective_service.dart';

class ReflectiveTestScreen extends StatefulWidget {
  @override
  _ReflectiveTestScreenState createState() => _ReflectiveTestScreenState();
}

class _ReflectiveTestScreenState extends State<ReflectiveTestScreen> {
  final _controller = TextEditingController();
  String? _analysisResult;
  String? _profileResult;
  bool _loading = false;

  final reflectiveService = CompanionReflectiveService();

  Future<void> _sendEntry() async {
    setState(() {
      _loading = true;
      _analysisResult = null;
      _profileResult = null;
    });
    try {
      final result = await reflectiveService.analyzeJournal(_controller.text);
      setState(() {
        _analysisResult = result['analysis'].toString();
        _profileResult = result['profile'].toString();
      });
    } catch (e) {
      setState(() {
        _analysisResult = 'Error: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reflective Core Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              minLines: 3,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Write your journal entry...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _sendEntry,
              child: _loading ? CircularProgressIndicator() : Text('Analyze'),
            ),
            const SizedBox(height: 24),
            if (_analysisResult != null) ...[
              Text('Analysis:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_analysisResult!),
              const SizedBox(height: 12),
              Text('Profile:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_profileResult ?? ''),
            ],
          ],
        ),
      ),
    );
  }
}