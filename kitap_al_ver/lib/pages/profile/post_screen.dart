import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/product/deail_screen.dart';

class PostScreen extends StatelessWidget {
  final String postUid; // Gönderi UID'si
  final String photoUrl; // Fotoğraf URL'si

  // Constructor'da gerekli parametreleri alıyoruz
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
