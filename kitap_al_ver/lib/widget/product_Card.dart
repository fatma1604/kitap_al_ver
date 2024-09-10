// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';

class ProductCard extends StatelessWidget {
  final String photoUrl;

  const ProductCard({
    super.key,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kcontentColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Center(
                child: Image.network(
                  photoUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              // Diğer widget'lar buraya eklenebilir.
            ],
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: kprimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  // Favorilere ekleme işlemi buraya eklenebilir.
                },
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
