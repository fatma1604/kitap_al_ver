import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  final String categoryTitle;

  const BooksScreen({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<DocumentSnapshot> _posts = [];
  List<String> _likedPostIds = []; // List to hold liked post IDs
  String? currentUserId; // Placeholder for current user ID

  @override
  void initState() {
    super.initState();
    currentUserId = getCurrentUserId(); // Get the current user ID
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
            .toList(); // Initialize liked posts
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
          _likedPostIds.remove(postId); // Remove from liked list
        });
      } else {
        await postRef.update({
          'like': FieldValue.arrayUnion([currentUserId]),
        });
        setState(() {
          _likedPostIds.add(postId); // Add to liked list
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
      ),
      body: _posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                bool isLiked =
                    _likedPostIds.contains(post.id); // Check if liked

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
                              child: photoUrl.isNotEmpty
                                  ? Image.network(
                                      photoUrl,
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/default_image.png',
                                          width: double.infinity,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/default_image.png',
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
