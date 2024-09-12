import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String title;
  final String postId;
  final List<String> imageUrls; // Updated to handle multiple image URLs
  final List<String> likes;

  Posts({
    required this.title,
    required this.postId,
    required this.imageUrls,
       this.likes = const []
  });

  factory Posts.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Posts(
      title: data['title'] ?? '',
      postId: doc.id,
      imageUrls: List<String>.from(data['postImages'] ?? []),
      likes: List<String>.from(data['like'] ?? []),
    );
  }
}
