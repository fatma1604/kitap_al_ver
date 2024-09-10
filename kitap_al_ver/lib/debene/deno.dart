

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:kitap_al_ver/model/product_model.dart';
import 'package:kitap_al_ver/provider/favorite_provider.dart';
import 'package:kitap_al_ver/screnn/deail_screen.dart';

//2
class ProductCard5 extends StatelessWidget {
  final Product product;
  const ProductCard5({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: product),
          ),
        );
      },
      child: Stack(
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
             
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                   "title",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                     "tür",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  
                  
                  ],
                )
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
                  provider.toggleFavorite(product);
                },
                child: Icon(
                  provider.isExist(product)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                  size: 22,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
