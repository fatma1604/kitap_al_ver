import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/model/usermodel.dart';

class FirebasePostServis {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreatePost({
    required String caption,
    required String location,
  }) async {
    try {
      DateTime now = DateTime.now();
      Usermodel user = await getUser();
      await _firebaseFirestore.collection('posts').add({
        'username': user.username,
        'profileImage': user.profile,
        'caption': caption,
        'location': location,
        'uid': _auth.currentUser!.uid,
        'like': [],
        'time': now,
      });

      return true;
    } catch (e) {
      print('Error in CreatePost: $e');
      return false;
    }
  }

  Future<Usermodel> getUser({String? UID}) async {
    try {
      final userDoc = await _firebaseFirestore
          .collection('Users')
          .doc(UID ?? _auth.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        return Usermodel(
          username: userData['username'],
          profile: userData['profile'],
          bio: userData['bio'],
          followers: List<String>.from(userData['followers'] ?? []),
          following: List<String>.from(userData['following'] ?? []),
        );
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Error in getUser: $e');
      rethrow;
    }
  }
}
