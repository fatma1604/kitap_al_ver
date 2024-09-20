// favorite_provider.dart
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart';

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
    notifyListeners();
  }

  // You can initialize _likedPostIds with data from Firestore here if needed
}
