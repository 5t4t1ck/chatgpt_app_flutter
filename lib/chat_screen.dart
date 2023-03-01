import 'dart:convert';

import 'package:chatgpt_app_flutter/chat_messag_tipe.dart';
import 'package:chatgpt_app_flutter/chat_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

Future<String> generateResponse(String prompt) async {
  const apiKey = "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";

  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(url,
      headers: {
        "Content-Type": "aplication/json",
        "Autorization": "Bearer $apiKey"
      },
      body: json.encode({
        "model": "text-davinci-003",
        "promt": prompt,
        "temperature": 1,
        "max_tokens": 4000,
        "top_p": 1,
        "frecuency_penality": 0.0,
        "presence_penality": 0.0,
      }));

  Map<String, dynamic> newresponse = jsonDecode(response.body);

  return newresponse["choices"][0]["text"];
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  @override
  void initSate() {
    super.initState();
    isLoading = true;
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI ChatBot GPT3 by Statick"),
        backgroundColor: Color.fromRGBO(16, 163, 127, 1),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF343541),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var message = _messages[index];

                  return ChatMessageWidget(
                    text: message.text,
                    chatMassageType: message.chatMessageType,
                  );
                },
              ),
            ),
            Visibility(
              // visible: isLoading,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(color: Colors.white),
                      controller: _textController,
                      decoration: InputDecoration(
                        fillColor: Color(0xFF444654),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isLoading,
                    child: Container(
                      color: Color(0xFF444654),
                      child: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: Color.fromRGBO(
                            142,
                            142,
                            160,
                            1,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _messages.add(
                              ChatMessage(
                                text: _textController.text,
                                chatMessageType: ChatMassageType.user,
                              ),
                            );
                            isLoading = false;
                          });
                          var input = _textController.text;
                          _textController.clear();
                          Future.delayed(Duration(microseconds: 50))
                              .then((_) => _scrollDown());
                          generateResponse(input).then((value) {
                            setState(() {
                              isLoading = false;
                              _messages.add(
                                ChatMessage(
                                    text: value,
                                    chatMessageType: ChatMassageType.bot),
                              );
                            });
                          });
                          _textController.clear();
                          Future.delayed(Duration(milliseconds: 50))
                              .then((_) => _scrollDown());
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
