import 'dart:convert';
import 'package:http/http.dart' as http;

class AIChatService {
  final String apiKey = 'AIzaSyAVuTT5RXc0SbHKIbqH69kNzzftPduBHPI'; // Replace with your Gemini API key

  Future<String> getAIResponse(String userMessage) async {
    final url = Uri.parse('https://api.openai.com/v1/engines/davinci/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = json.encode({
      'prompt': userMessage,
      'max_tokens': 150,
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['text'].trim();
    } else {
      throw Exception('Failed to load AI response');
    }
  }
}
