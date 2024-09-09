import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/model/usermodel.dart';
import 'package:uuid/uuid.dart';

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
   Future<String> like({
    required List like,
    required String type,
    required String uid,
    required String postId,
  }) async {
    try {
      if (like.contains(uid)) {
        await _firebaseFirestore.collection(type).doc(postId).update({
          'like': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firebaseFirestore.collection(type).doc(postId).update({
          'like': FieldValue.arrayUnion([uid]),
        });
      }
      return 'Success';
    } catch (e) {
      print('Error in like: $e');
      return 'Error: $e';
    }
  }
   Future<bool> Comments({
    required String comment,
    required String type,
    required String uidd,
  }) async {
    try {
      var uid = Uuid().v4();
      Usermodel user = await getUser();
      await _firebaseFirestore
          .collection(type)
          .doc(uidd)
          .collection('comments')
          .doc(uid)
          .set({
        'comment': comment,
        'username': user.username,
        'profileImage': user.profile,
        'CommentUid': uid,
      });
      return true;
    } catch (e) {
      print('Error in Comments: $e');
      return false;
    }
  }
   Future<void> flollow({
    required String uid,
  }) async {
    try {
      DocumentSnapshot snap = await _firebaseFirestore
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .get();
      List following = snap.get('following') ?? [];
      if (following.contains(uid)) {
        await _firebaseFirestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .update({
          'following': FieldValue.arrayRemove([uid]),
        });
        await _firebaseFirestore.collection('Users').doc(uid).update({
          'followers': FieldValue.arrayRemove([_auth.currentUser!.uid]),
        });
      } else {
        await _firebaseFirestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .update({
          'following': FieldValue.arrayUnion([uid]),
        });
        await _firebaseFirestore.collection('Users').doc(uid).update({
          'followers': FieldValue.arrayUnion([_auth.currentUser!.uid]),
        });
      }
    } catch (e) {
      print('Error in follow: $e');
    }
  }


}
