import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart';
import 'package:kitap_al_ver/provider/favorite_provider.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:provider/provider.dart';

class DetailAppBar extends StatelessWidget {
  final Posts posts;

  const DetailAppBar({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColor.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                
               Navigator.pushNamed(context, '/liquidTab');

                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              const Spacer(),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColor.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                   Navigator.pushNamed(context, '/card');
                },
                icon: const Icon(
                  Icons.add_shopping_cart_rounded,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColor.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  provider.toggleFavorite(posts);
                },
                icon: Icon(
                  provider.isExist(posts)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
