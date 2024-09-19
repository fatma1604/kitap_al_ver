// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      var uid = const Uuid().v4();
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

  Future<void> addLikeToPost(String postId) async {
    try {
      final postRef = FirebaseFirestore.instance.collection('post').doc(postId);

      await postRef.update({
        'like': FieldValue.arrayUnion([getCurrentUserId()]),
      });

      print('Like successfully added to the post.');
    } catch (e) {
      print('Error adding like: $e');
    }
  }

  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getPhotoUrls() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('post').get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final postImages = data['postImages'] as List<dynamic>?;

          // İlk resim URL'sini al (eğer liste boş değilse)
          final url = postImages != null && postImages.isNotEmpty
              ? postImages[0] as String?
              : 'assets/images/onbord1.jpeg'; // Fallback asset URL
          final title = data['title'] as String? ?? 'No Title';
          final type = data['type'] as String? ?? 'No Genre';
          final postUid = data['post_uid'] as String? ?? 'No UID';

          return {
            'postImage': url,
            'title': title,
            'type': type,
            'postUid': postUid
          };
        }).toList();
      } else {
        return []; // No documents found
      }
    } catch (e) {
      print('Error fetching photo URLs: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<List<String>> loadImageUrls() async {
    try {
      final ListResult result =
          await FirebaseStorage.instance.ref('deneme').listAll();

      final List<String> urls = [];
      for (var ref in result.items) {
        final String url = await ref.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } catch (e) {
      print('Error loading image URLs: $e');
      return [];
    }
  }
  

  
}
