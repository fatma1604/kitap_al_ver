import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart';

class PostsPage extends StatefulWidget {
  final String category;

  const PostsPage({Key? key, required this.category}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('post')
          .where('post_uid', isEqualTo: widget.category)
          .get();

      if (snapshot.docs.isEmpty) {
        print('No posts found for this category.');
      }

      setState(() {
        posts = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final postData = posts[index];
        final post = Posts(
          postId: postData['post_uid'] ?? '',
          title: postData['title'] ?? 'No Title',
          likes: List<String>.from(postData['like'] ?? []),
          imageUrls: List<String>.from(postData['postImages'] ?? []),
          rating: postData['usageStatus'] ?? 'unknown',
          userName: postData['username'] ?? 'defaultUser',
          category: postData['category'] ?? 'uncategorized',
        );

        return Stack(
          children: [
            _buildCardContent(post),
          ],
        );
      },
    );
  }

  Widget _buildCardContent(Posts post) {
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: post.imageUrls.isNotEmpty
                  ? Image.network(
                      post.imageUrls[0],
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_image.png',
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/default_image.png',
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
              post.title.isNotEmpty ? post.title : 'No Title',
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
              post.category.isNotEmpty ? post.category : 'No Category',
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
}
