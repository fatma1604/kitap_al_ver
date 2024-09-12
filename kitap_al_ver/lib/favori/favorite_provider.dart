import 'package:flutter/material.dart';
// `Product` modelini buraya ekleyin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/favori/post.dart';
import 'package:provider/provider.dart'; // `Posts` modelini buraya ekleyin

class FavoriteProvider extends ChangeNotifier {
  final List<Posts> _favorite = [];

  List<Posts> get favorites => _favorite;

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('uid')
          .doc(userId)
          .collection('favorites')
          .get();

      _favorite.clear();
      for (var doc in snapshot.docs) {
        final post = Posts.fromFirestore(doc);
        _favorite.add(post);
      }
      notifyListeners();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  void toggleFavorite(Posts post) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    if (_favorite.contains(post)) {
      _favorite.remove(post);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(post.postId)
          .delete();
    } else {
      _favorite.add(post);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(post.postId)
          .set({
        'title': post.title,
        'postImages': post.imageUrls,
        'like': post.likes,
      });
    }
    notifyListeners();
  }

  bool isExist(Posts post) {
    return _favorite.contains(post);
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
