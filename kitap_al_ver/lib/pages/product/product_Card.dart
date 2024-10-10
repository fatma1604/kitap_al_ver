// ProductCard.dart
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart';
import 'package:kitap_al_ver/pages/product/deail_screen.dart';
import 'package:kitap_al_ver/provider/favorite_provider.dart';
import 'package:kitap_al_ver/service/firebes_post.dart';
import 'package:kitap_al_ver/utils/images.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final String photoUrl;
  final String title;
  final String genre;
  final String postUid;

  const ProductCard({
    super.key,
    required this.photoUrl,
    required this.title,
    required this.genre,
    required this.postUid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(postUid: postUid, photoUrl: photoUrl),
          ),
        );
      },
      child: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          final post = Posts(
            postId: postUid,
            title: title,
            likes: [],
            imageUrls: [],
            rating: "",
            userName: "",
            category: genre,
          );

          return Stack(
            children: [
              _buildCardContent(),
              _buildFavoriteButton(provider, post),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCardContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(172, 228, 214, 214),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Center(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: photoUrl.isNotEmpty
                  ? Image.network(
                      photoUrl,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImage.product,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      AppImage.profil,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title.isNotEmpty ? title : 'No Title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Text(
              genre.isNotEmpty ? genre : 'No Genre',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(FavoriteProvider provider, Posts post) {
    return Positioned(
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () async {
            provider.toggleFavorite(post);
            final firebaseService = FirebasePostServis();
            firebaseService.addLikeToPost(post.postId);
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Icon(
              provider.isExist(post) ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}