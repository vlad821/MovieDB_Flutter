import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/chat/components/chat_bubble.dart';
import 'package:movies/chat/services/chat/chat_service.dart';
import 'package:movies/screens/auth/my_textfield.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverID;
  const ChatPage(
      {super.key, required this.receiverUserEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverUserEmail,style: TextStyle(color: Colors.black),),
        ),
        body: Container(
           decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 123, 5, 5),
                Color.fromARGB(255, 60, 2, 2)
              ], // Change colors as needed
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 12,
          vertical: MediaQuery.of(context).size.height / 12,
        ),
        
            child: Column(
              children: [
                //messages
                Expanded(
                  child: _buildMessageList(),
                ),
                //user input
                _buildMessageInput(),
              ],
            ),
          ),
        ));
  }
  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }
  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
             mainAxisAlignment:
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Text(data['senderEmail']),
              ChatBubble(message:data['message']),
            ]),
      ),
    );
  }
  //build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        //tewxtfield
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: 'Enter message',
            obscureText: false,
          ),
        ),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send, size: 40, color: Colors.white),
            )
      ],
    );
  }
}
