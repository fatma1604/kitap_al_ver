// ignore_for_file: use_super_parameters, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/utils/color.dart';
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
  String? currentUserId;
  @override
  void initState() {
    super.initState();
    currentUserId = getCurrentUserId();
    _fetchPost();
  }

  Future<void> _fetchPost() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('post')
          .where('category', isEqualTo: widget.categoryTitle)
          .get();

      setState(() {
        _posts = snapshot.docs;
        _likedPostIds = snapshot.docs
            .where((post) =>
                (post['like'] as List<dynamic>?)?.contains(currentUserId) ??
                false)
            .map((post) => post.id)
            .toList();
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  Future<void> _toggleLike(String postId) async {
    try {
      final postRef = FirebaseFirestore.instance.collection('post').doc(postId);
      bool isLiked = _likedPostIds.contains(postId);

      if (isLiked) {
        await postRef.update({
          'like': FieldValue.arrayRemove([currentUserId]),
        });
        setState(() {
          _likedPostIds.remove(postId);
        });
      } else {
        await postRef.update({
          'like': FieldValue.arrayUnion([currentUserId]),
        });
        setState(() {
          _likedPostIds.add(postId);
        });
      }
    } catch (e) {
      print('Error updating like status: $e');
    }
  }

  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? AppColor.screendart : AppColor.screenlight,
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColor.darttBg : AppColor.lightBg,
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
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/bookscateg');
                      },
                      child: Text('RESİM ATMAYA NE DERSİN ',
                          style: AppTextTheme.largeTitle(context))),
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
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20)),
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
                            child: Text(title.isNotEmpty ? title : 'No Title',
                                style: AppTextTheme.emphasized(context)),
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
