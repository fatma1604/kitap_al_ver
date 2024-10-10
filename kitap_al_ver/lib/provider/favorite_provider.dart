import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart'; // Adjust import as necessary

class FavoriteProvider with ChangeNotifier {
  final Set<String> _likedPostIds = {};

  bool isExist(Posts post) {
    return _likedPostIds.contains(post.postId);
  }

  void toggleFavorite(Posts post) {
    if (isExist(post)) {
      _likedPostIds.remove(post.postId);
    } else {
      _likedPostIds.add(post.postId);
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  // Optionally, you can load existing liked posts from Firestore or other sources here
  void loadLikedPosts(Set<String> likedPosts) {
    _likedPostIds.addAll(likedPosts);
    notifyListeners();
  }

  Set<String> get likedPostIds => _likedPostIds; // Expose liked posts if needed
}
