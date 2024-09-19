// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/core/user_title.dart';
import 'package:kitap_al_ver/pages/chat/chat_page.dart';
import 'package:kitap_al_ver/pages/chat/chat_service.dart';
import 'package:kitap_al_ver/pages/data/firebes_auth.dart';

class ChatHome extends StatelessWidget {
  final ChatService _chatService = ChatService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  ChatHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUsersStream(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        print("User Data: ${snapshot.data}");
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTitle(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData["email"],
                        receiverId: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
