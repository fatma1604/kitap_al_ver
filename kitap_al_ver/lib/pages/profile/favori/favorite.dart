// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/components/animated_card.dart';
import 'package:kitap_al_ver/models/post.dart';
import 'package:kitap_al_ver/utils/color.dart';

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? AppColor.screendart // Use the dark theme color
          : AppColor.screenlight, // Use the light theme color
      appBar: AppBar(
        title: const Text(
          "Favorite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // Optionally set the AppBar's background color based on theme as well
        backgroundColor: theme.brightness == Brightness.dark
            ? AppColor.screendart // Define this color in your AppColor class
            : AppColor.screenlight, // Define this color in your AppColor class
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
            return const Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data!.docs
              .map((doc) => Posts.fromFirestore(doc))
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
