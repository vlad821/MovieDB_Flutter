import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:const Color.fromARGB(255, 251, 253, 255),
      ),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(fontSize: 25,color: Color.fromARGB(255, 0, 0, 0)),
        ),
      )
    );
  }
}
