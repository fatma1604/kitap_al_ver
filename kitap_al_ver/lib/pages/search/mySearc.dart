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
            ? AppColor.onbordingdark
            : AppColor.screenlight1,
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Explone()));
            },
            icon: const Icon(Icons.search, color: AppColor.white),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              ' ARAYALIM',
              style: TextStyle(
                color: AppColor.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
