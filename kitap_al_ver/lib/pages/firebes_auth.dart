// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/costant/show_alert_dialog.dart';
import 'package:kitap_al_ver/configuration/costant/theme/text.dart';
import 'package:kitap_al_ver/data/stroge.dart';
import 'package:kitap_al_ver/tabbar/liquidTabbar.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user information in Firestore
      await _firebaseFirestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LiquidTabBar()),
      );
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
    // Şifrelerin eşleşip eşleşmediğini kontrol et
    if (password != confirmPassword) {
      showAlertDialog(
        context: context,
        message: AppText.match,
      );
      return;
    }

    try {
      // Kullanıcıyı Firebase Authentication ile oluştur
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Eğer profil resmi varsa, resmi yükle ve URL'sini al
      String URL = '';
      if (profile.path.isNotEmpty) {
        URL = await StorageMethod().uploadImageToStorage('Profile', profile);
      }

      // Kullanıcı bilgilerini Firestore'a ekle
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
        'followers': [],
        'following': [],
        'profile': URL.isEmpty
            ? 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab'
            : URL,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppText.showmessaj)),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LiquidTabBar()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showAlertDialog(
          context: context,
          message: AppText.emailuse,
        );
      } else if (e.code == 'invalid-email') {
        showAlertDialog(
          context: context,
          message: AppText.invalide,
        );
      } else {
        showAlertDialog(
          context: context,
          message: '${AppText.allerterror}',
        );
      }
    } catch (e) {
      showAlertDialog(
        context: context,
        message: AppText.allerterror,
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  void _handleAuthError(BuildContext context, FirebaseAuthException e) {
    String errorMessage = AppText.enterUsernamePassword;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = AppText.userNotFound;
        break;
      case 'invalid-email':
        errorMessage = AppText.invalide;
        break;
      case 'network-request-failed':
        errorMessage = AppText.networkError;
        break;
      case 'wrong-password':
        errorMessage = AppText.wrongPassword;
        break;
      default:
        errorMessage = '${AppText.wrongPassword}: ${e.code}';
    }
    showAlertDialog(context: context, message: errorMessage);
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
}
