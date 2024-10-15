// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/chat/chat_page.dart';
import 'package:kitap_al_ver/pages/widget/core/user_title.dart';
import 'package:kitap_al_ver/service/chat_service.dart';
import 'package:kitap_al_ver/service/firebes_auth.dart';
import 'package:kitap_al_ver/utils/color.dart';

class ChatHome extends StatelessWidget {
  final ChatService _chatService = ChatService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  ChatHome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? AppColor.screendart : AppColor.screenlight,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/liquidTab');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColor.screendart
          : AppColor.screenlight,
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
      String userName = userData["username"] ?? "Unknown User"; // Null kontrolü

      return UserTitle(
        text: userName, // E-posta yerine kullanıcı adını kullan
        profileImageUrl:
            userData["profile"] ?? "", // Profil resmi için de null kontrolü
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
