// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/product/deail_screen.dart';

class PostScreen extends StatelessWidget {
  final String postUid; 
  final String photoUrl; 

  
  PostScreen({
    super.key,
    required this.postUid,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DetailScreen(
          postUid: postUid,
          photoUrl: photoUrl,
        ),
      ),
    );
  }
}
