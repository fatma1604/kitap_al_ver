// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/core/dataSesrch.dart';
// ignore: depend_on_referenced_packages


class MySearchWidget extends StatelessWidget {
  final TextEditingController searchController;

  // ignore: use_key_in_widget_constructors
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
              showSearch(context: context, delegate: DataSearch());
            },
            icon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Search',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );

    /*TextFormField(
        controller: searchController,
        textAlign: TextAlign.start, // Center-aligns the text horizontally
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 26.0,vertical: 20),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ),
      ),);*/
  }
}
