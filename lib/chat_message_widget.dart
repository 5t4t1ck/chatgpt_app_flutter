import 'package:chatgpt_app_flutter/chat_messag_tipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {

  final String text;
  final ChatMassageType chatMassageType;
  ChatMessageWidget({required this.text, required this.chatMassageType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      color: chatMassageType == ChatMassageType.bot ? 
      Color(0xFF444654): 
      Color(0xFF343541),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chatMassageType == ChatMassageType.bot ? Container(
            margin: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(16, 163, 127, 1),
              child: Image.asset("images/bot.png",
              color: Colors.white, scale: 1.5, ), 
            ),
          ) : Container(
            margin: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Color(0xFF444654),
              child: Icon(
                CupertinoIcons.person_alt,
              ),
            ),
          ),

          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  text, 
                  style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white)),),
            ],
          ))
        ],
      ),
    );
  }
}
