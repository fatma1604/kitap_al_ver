import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart';
 // Ensure you have this model defined

class FavoriteProvider with ChangeNotifier {
  // Assuming you have a list or a set to keep track of liked posts
  final Set<String> _likedPostIds = {};

  bool isExist(Posts post) {
    return _likedPostIds.contains(post.postId); // Check if post is in the liked list
  }

  void toggleFavorite(Posts post) {
    if (isExist(post)) {
      _likedPostIds.remove(post.postId); // Remove if already liked
    } else {
      _likedPostIds.add(post.postId); // Add if not liked
    }
    notifyListeners(); // Notify listeners to update UI
  }

  // Optionally, you might want to initialize _likedPostIds with data from Firestore
}
