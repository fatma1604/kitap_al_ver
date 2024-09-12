import 'package:flutter/material.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            splashColor: Colors.grey[300],
            highlightColor: Colors.grey[200],
            constraints: const BoxConstraints(),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              // Implement share functionality
            },
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            splashColor: Colors.grey[300],
            highlightColor: Colors.grey[200],
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black), // Favori butonu için ikon
            onPressed: () {
              // Implement favorite functionality
            },
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            splashColor: Colors.grey[300],
            highlightColor: Colors.grey[200],
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
