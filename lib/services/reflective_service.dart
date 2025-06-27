import 'dart:convert';
import 'package:http/http.dart' as http;

class CompanionReflectiveService {
  final String apiUrl;

  CompanionReflectiveService({this.apiUrl = 'http://127.0.0.1:8080/analyze'});

  Future<Map<String, dynamic>> analyzeJournal(String text) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to analyze journal: ${response.body}');
    }
  }
}

final reflectiveService = CompanionReflectiveService();

void sendReflection(String text) async {
  try {
    final result = await reflectiveService.analyzeJournal(text);
    print('Analysis: ${result['analysis']}');
    print('Profile: ${result['profile']}');
    // Εδώ μπορείς να ενημερώσεις το UI ή να αποθηκεύσεις τα αποτελέσματα
  } catch (e) {
    print('Error: $e');
  }
}