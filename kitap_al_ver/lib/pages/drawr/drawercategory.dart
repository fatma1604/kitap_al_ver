// ignore_for_file: use_super_parameters, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/service/firebes_post.dart';
import 'package:kitap_al_ver/utils/images.dart';


class DrawerCategoryScreen extends StatefulWidget {
  final String categoryTitle;

  const DrawerCategoryScreen({Key? key, required this.categoryTitle})
      : super(key: key);

  @override
  _DrawerCategoryScreenState createState() => _DrawerCategoryScreenState();
}

class _DrawerCategoryScreenState extends State<DrawerCategoryScreen> {
  List<DocumentSnapshot> _posts = [];
  List<String> _likedPostIds = [];
  final FirebasePostServis _firebasePostServis = FirebasePostServis();
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = getCurrentUserId();
   
  }

  Future<void> _toggleLike(String postId) async {
    await _firebasePostServis.toggleLike(postId, currentUserId);

    setState(() {
      if (_likedPostIds.contains(postId)) {
        _likedPostIds.remove(postId);
      } else {
        _likedPostIds.add(postId);
      }
    });
  }

  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
      ),
      body: _posts.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImage.books,
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'RESİM ATMAYA NE DERSİN ',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                var post = _posts[index];
                var images = post['postImages'] as List<dynamic>;
                String photoUrl = images.isNotEmpty ? images[0] : '';
                String title = post['title'] ?? 'No Title';
                bool isLiked = _likedPostIds.contains(post.id);

                return Stack(
                  children: [
                    Container(
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
                              child: Image.network(
                                photoUrl,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center();
                                },
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
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                        ),
                        onPressed: () {
                          _toggleLike(post.id);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
