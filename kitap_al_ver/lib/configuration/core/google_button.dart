


// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kitap_al_ver/configuration/costant/images.dart';
import 'package:kitap_al_ver/configuration/costant/theme/text.dart';
import 'package:kitap_al_ver/tabbar/liquidTabbar.dart';

//liqutabar eklicez 
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

      await FirebaseAuth.instance.signInWithCredential(credential);
      navigateToHome(context); // Redirect to home page
    } else {
      // Google sign-in failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppText.google),
          content: const Text(AppText.plaseconfigure),
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
  } catch (error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppText.error),
        content: const Text(AppText.google),
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
        backgroundColor: MaterialStateProperty.all<Color>(
            Colors.transparent), // Arka plan rengini beyaz yapar
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
