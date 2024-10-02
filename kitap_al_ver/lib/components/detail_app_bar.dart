import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/tabbar/liquidTabbar.dart';
import 'package:kitap_al_ver/models/post.dart';
import 'package:kitap_al_ver/pages/drawr/drawerDemo_Screen.dart';
import 'package:kitap_al_ver/pages/home/books_home.dart';
import 'package:kitap_al_ver/pages/product/cartPage.dart';
import 'package:kitap_al_ver/provider/favorite_provider.dart';
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiquidTabBar(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_shopping_cart_rounded,
                  color: Colors.black,
                ),
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
