import 'package:electronicsrent/Screens/services/ai_chat_service.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  static const String id = 'chat-page';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final AIChatService _aiChatService = AIChatService(); // Correct instantiation

  List<Map<String, String>> _messages = [];

  void _sendMessage(String message) async {
    setState(() {
      _messages.add({'user': message});
    });

    try {
      String aiResponse = await _aiChatService.getAIResponse(message);
      setState(() {
        _messages.add({'ai': aiResponse});
      });
    } catch (e) {
      print('Error fetching AI response: $e');
      // Handle error, show message, etc.
    }
  }

  Widget _buildMessageItem(Map<String, String> message) {
    bool isUser = message.keys.first == 'user';
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: isUser ? Colors.blueAccent : Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message.values.first,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageItem(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_controller.text);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
