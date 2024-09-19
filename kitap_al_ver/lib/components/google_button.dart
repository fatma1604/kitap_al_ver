// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kitap_al_ver/pages/widget/theme/text.dart';
import 'package:kitap_al_ver/components/tabbar/liquidTabbar.dart';
import 'package:kitap_al_ver/utils/images.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Check if the user exists in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        String profileUrl = googleUser.photoUrl ?? ''; // Get profile URL

        if (!userDoc.exists) {
          // User does not exist, create a new user record
          await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
            'uid': userCredential.user!.uid,
            'email': user.email, // Use the user's email from the Google account
            'username': user.displayName ?? 'User', // Use the user's name from the Google account
            'followers': [],
            'following': [],
            'profile': profileUrl.isNotEmpty
                ? profileUrl
                : 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab', // Default image if profile URL is empty
          });
        }

        // Navigate to home page after successful sign-in
        navigateToHome(context);
      }
    } else {
      // Google sign-in failed
      _showErrorDialog(context, AppText.google, AppText.plaseconfigure);
    }
  } catch (error) {
    _showErrorDialog(context, AppText.error, AppText.google);
  }
}

void _showErrorDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(AppText.dialogYes),
        ),
      ],
    ),
  );
}

void navigateToHome(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LiquidTabBar()),
  );
}

// ignore: use_key_in_widget_constructors
class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        signInWithGoogle(context);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), // Set background color to transparent
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            AppImage.google,
            height: 50.0.h,
          ),
        ],
      ),
    );
  }
}
