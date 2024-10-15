
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/widget/theme/tehm_provider.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:provider/provider.dart';



class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {Key? key, required this.message, required this.isCurrentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemProvider>(context)
        .isDarkMode; 

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
        style: const TextStyle(color: AppColor.white),
      ),
    );
  }
}