import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:provider/provider.dart';
import 'package:kitap_al_ver/favori/favorite_provider.dart';
import 'package:kitap_al_ver/favori/post.dart'; // Ensure you have this model defined
import 'package:kitap_al_ver/detay/deail_screen.dart';

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
            builder: (context) => DetailScreen(postUid: postUid),
          ),
        );
      },
      child: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          final post = Posts(
            postId: postUid,
            title: title, likes: [],
            imageUrls: [],
            rating: "",
            userName: "",

            category: genre,

            // Assuming title represents genre here
          );

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
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        title,
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
                        genre,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
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
                        provider.toggleFavorite(post);
                        addLikeToPost(
                            postUid); // Update Firestore with the like action
                      },
                      child: Icon(
                        provider.isExist(post)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> addLikeToPost(String postId) async {
    try {
      final postRef = FirebaseFirestore.instance.collection('post').doc(postId);

      await postRef.update({
        'like': FieldValue.arrayUnion([getCurrentUserId()]),
      });

      print('Like successfully added to the post.');
    } catch (e) {
      print('Error adding like: $e');
    }
  }

  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid; // Kullanıcının benzersiz ID'sini döndürür
    } else {
      return null; // Kullanıcı oturum açmamışsa null döner
    }
  }
}
