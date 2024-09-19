import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/chat/chat_bubla.dart';
import 'package:kitap_al_ver/chat/chat_service.dart';
import 'package:kitap_al_ver/chat/my_textfild.dart';
import 'package:kitap_al_ver/pages/data/firebes_auth.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;

  final String receiverId;

  // ignore: use_super_parameters
  ChatPage({Key? key, required this.receiverEmail, required this.receiverId})
      : super(key: key);

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuthService _autService = FirebaseAuthService();
  void sendMessage() async {
    _chatService.sendMessage(
        receiverId, _messageController.text, _messageController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _autService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverId, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No messages yet.");
        }

      

        return ListView(
          children: (snapshot.data!.docs.map((doc) => _buildMessageItem(doc)))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _autService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
              child: MyTexfild(
                  text: "MESAJ",
                  obscurText: false,
                  controller: _messageController)),
          Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 32, 20, 49)),
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.arrow_left_sharp,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
