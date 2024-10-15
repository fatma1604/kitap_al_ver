import 'package:flutter/material.dart';
import 'package:kitap_al_ver/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<String> _favoritePosts = [];

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoritePosts = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }

  void toggleFavorite(Posts post) {
    if (_favoritePosts.contains(post.postId)) {
      _favoritePosts.remove(post.postId);
    } else {
      _favoritePosts.add(post.postId);
    }
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favoritePosts);
  }

  bool isExist(Posts post) {
    return _favoritePosts.contains(post.postId);
  }
}
