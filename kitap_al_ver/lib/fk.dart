import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart';
import 'package:kitap_al_ver/provider/favorite_provider.dart';
import 'package:kitap_al_ver/service/firebes_post.dart';
import 'package:provider/provider.dart';

class Fk extends StatefulWidget {
  final String photoUrl;
  final String title;
  final String genre;
  final String postUid;
  final String categoryTitle;

  const Fk({
    Key? key,
    required this.photoUrl,
    required this.title,
    required this.genre,
    required this.postUid,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  State<Fk> createState() => _FkState();
}

class _FkState extends State<Fk> {
  List<DocumentSnapshot> _posts = []; // Changed to non-final

  @override
  void initState() {
    super.initState();
    _fetchPost(); // Fetch posts
  }

  Future<void> _fetchPost() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('post')
          .where('category',
              isEqualTo: widget.categoryTitle) // Filter by category
          .get();

      setState(() {
        _posts = snapshot.docs; // Assign posts to the list
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        final post = Posts(
          postId: widget.postUid,
          title: widget.title,
          likes: [],
          imageUrls: [],
          rating: "",
          userName: "",
          category: widget.genre,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.categoryTitle),
          ),
          body: _posts.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    childAspectRatio: 0.75, // Height/Width ratio
                    crossAxisSpacing: 8.0, // Column spacing
                    mainAxisSpacing: 8.0, // Row spacing
                  ),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    var postSnapshot = _posts[index];
                    var images = postSnapshot['postImages']
                        as List<dynamic>; // Get images list
                    String photoUrl =
                        images.isNotEmpty ? images[0] : ''; // Get first image
                    String title =
                        postSnapshot['title'] ?? 'No Title'; // Get title

                    return Stack(
                      children: [
                        _buildCardContent(photoUrl, title),
                        _buildFavoriteButton(provider, post),
                      ],
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _buildCardContent(String photoUrl, String title) {
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
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: photoUrl.isNotEmpty
                  ? Image.network(
                      photoUrl,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/default_image.png', // Default image path
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/default_image.png', // Default image path
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
    );
  }

  Widget _buildFavoriteButton(FavoriteProvider provider, Posts post) {
    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () async {
          provider.toggleFavorite(post);
          final firebaseService = FirebasePostServis();

          await firebaseService
              .addLikeToPost(post.postId); // Ensure post ID is correct

          // Optionally handle UI state based on success/failure
           setState(() {});
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
    );
  }
}
