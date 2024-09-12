import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:kitap_al_ver/favori/animated.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('post')
            .where('like',
                arrayContains:
                    _currentUserId) // Filter posts liked by current user
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data!.docs
              .map((doc) => Post.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return Dismissible(
                key: Key(post.postId),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  // Trigger deletion animation and remove the post
                  await _deletePost(post.postId);
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40,
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: AnimatedPostCard(
                  post: post,
                  onDelete: () {
                    _deletePost(post.postId);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deletePost(String postId) async {
    await _firestore.collection('post').doc(postId).delete();
  }
}

class Post {
  final String title;
  final String postId;
  final List<String> imageUrls; // Updated to handle multiple image URLs
  final List<String> likes;

  Post({
    required this.title,
    required this.postId,
    required this.imageUrls,
    required this.likes,
  });

  factory Post.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      title: data['title'] ?? '',
      postId: doc.id,
      imageUrls: List<String>.from(data['postImages'] ?? []),
      likes: List<String>.from(data['like'] ?? []),
    );
  }
}
