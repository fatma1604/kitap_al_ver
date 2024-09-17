// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/aramabut/explore.dart'; // Eksik olan sayfa importu

class MySearchWidget extends StatelessWidget {
  final TextEditingController searchController;

  const MySearchWidget({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 157, 157),
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Explone(),
                ),
              );
            },
            icon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'KİTAPLARI ARAYALIM',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
