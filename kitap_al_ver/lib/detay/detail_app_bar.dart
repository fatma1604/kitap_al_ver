import 'package:flutter/material.dart';
import 'package:kitap_al_ver/favori/favorite_provider.dart';
import 'package:kitap_al_ver/favori/post.dart';
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
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const Spacer(),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
              ),
              const SizedBox(width: 10),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
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
                  size: 25,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
}
