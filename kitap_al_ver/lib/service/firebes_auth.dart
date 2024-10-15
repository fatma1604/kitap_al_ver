// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/utils/show_alert_dialog.dart';
import 'package:kitap_al_ver/pages/widget/theme/text.dart';
import 'package:kitap_al_ver/utils/stroge.dart';



class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
 User? getCurrentUser() {
    return _auth.currentUser;
  }
  Future<List<Map<String, dynamic>>> getNotifications() async {
    try {
      QuerySnapshot snapshot = await _firebaseFirestore
          .collection('chat_rooms')
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => {
        'title': doc['title'],
        'message': doc['message'],
        'timestamp': doc['timestamp'],
      }).toList();
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }
  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      showAlertDialog(context: context, message: AppText.enterUsernamePassword);
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

 
      await _storeUserInfo(userCredential.user!.uid, email);
Navigator.pushNamed(context, '/liquidTab');
     
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e);
    }
  }
Future<void> registerUser({
  required BuildContext context,
  required String email,
  required String password,
  required String confirmPassword,
  required String username,
  required File profile,
}) async {
 
  if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || username.isEmpty) {
    showAlertDialog(context: context, message: AppText.allFieldsRequired);
    return;
  }


  if (password != confirmPassword) {
    showAlertDialog(context: context, message: AppText.match);
    return;
  }

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    String profileUrl = '';
    if (profile.path.isNotEmpty) {
      profileUrl = await StorageMethod().uploadImageToStorage('Profile', profile);
    }

    await _firebaseFirestore.collection("Users").doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
      'username': username,
      'followers': [],
      'following': [],
      'profile': profileUrl.isEmpty
          ? 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab'
          : profileUrl,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppText.registrationSuccessful)),
    );

   Navigator.pushNamed(context, '/card');
  } on FirebaseAuthException catch (e) {
    _handleRegistrationError(context, e);
  } catch (e) {
    showAlertDialog(context: context, message: AppText.generalError);
  }
}


  Future<void> signOut() async {
    await _auth.signOut();
  }

 
  Future<void> handlePasswordReset({
    required BuildContext context,
    required String email,
  }) async {
    if (email.trim().isEmpty) {
      showAlertDialog(
        context: context,
        message: AppText.forgetEmail,
      );
      return;
    }

    try {
      final signInMethods =
          await _auth.fetchSignInMethodsForEmail(email.trim());

      if (signInMethods.isEmpty) {
        showAlertDialog(
          context: context,
          message: AppText.wrongEmail,
        );
        return;
      }

      await _auth.sendPasswordResetEmail(email: email.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppText.trueEmail)),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = AppText.invalide;
          break;
        default:
          errorMessage = AppText.error;
      }
      showAlertDialog(
        context: context,
        message: errorMessage,
      );
    }
  }

  Future<void> _storeUserInfo(String uid, String email) async {
    await _firebaseFirestore.collection("Users").doc(uid).set({
      'uid': uid,
      'email': email,
    }, SetOptions(merge: true)); 
  }

  void _handleAuthError(BuildContext context, FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
     case 'invalid-credential':
          errorMessage =
             AppText.wrongPasandEml; 
          break;
       case 'invalid-email':
          errorMessage =
        AppText.invalideEpos; 
          break;
      case 'network-request-failed':
        errorMessage =" AppText.networkError";
        break;
     
      default:
        errorMessage = '${"bilimeyen hata"}: ${e.code}';
    }

    showAlertDialog(context: context, message: errorMessage);
  }

void _handleRegistrationError(BuildContext context, FirebaseAuthException e) {
  String errorMessage;
  switch (e.code) {
    case 'email-already-in-use':
      errorMessage = AppText.emailuse;
      break;
    case 'invalid-email':
      errorMessage =  AppText.invalideEpos;
      break;
   
    default:
      errorMessage = AppText.registrationError;
  }
  showAlertDialog(context: context, message: errorMessage);
}

  



}
