import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String title;
  final String postId;
  final List<String> imageUrls;
  final List<String> likes;
  final String category;
  final String rating;
  final String userName;

  Posts({
    required this.title,
    required this.postId,
    required this.imageUrls,
    required this.category,
    required this.rating,
    this.likes = const [],
    required this.userName,
  });

  factory Posts.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Posts(
      title: data['title'] ?? '',
      postId: doc.id,
      imageUrls: List<String>.from(data['postImages'] ?? []),
      likes: List<String>.from(data['like'] ?? []),
      category: data['category'] ?? 'uncategorized', 
      rating: data['usageStatus'] ?? 'unknown', 
      userName: data['username'] ?? 'defaultUser',
    );
  }
}
