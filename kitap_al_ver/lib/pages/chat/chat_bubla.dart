
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/chat/them_provider.dart';

import 'package:provider/provider.dart';

// ThemeProvider'ı ekledim, isDarkMode değişkenini almak için

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  // ignore: use_super_parameters
  const ChatBubble(
      {Key? key, required this.message, required this.isCurrentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemProvider>(context)
        .isDarkMode; // isDarkMode değişkenini alıyorum

    return Container(
      
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMode ? Colors.green.shade600 : Colors.grey.shade500)
            : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}