// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/misc/explone.dart';
import 'package:kitap_al_ver/utils/color.dart';


class MySearchWidget extends StatelessWidget {
  final TextEditingController searchController;

  const MySearchWidget({required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 165,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 139, 81, 81) // Dark mode colory
            : const Color.fromARGB(255, 243, 157, 157), // Light mode color
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
            icon: const Icon(Icons.search,
                color: Color.fromARGB(255, 239, 227, 227)),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              ' ARAYALIM',
              style: TextStyle(
                color: AppColor.icon,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
