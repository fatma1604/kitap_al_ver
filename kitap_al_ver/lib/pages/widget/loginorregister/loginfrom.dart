
// ignore_for_file: use_build_context_synchronously


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitap_al_ver/configuration/core/google_button.dart';
import 'package:kitap_al_ver/configuration/core/my_button.dart';
import 'package:kitap_al_ver/configuration/core/my_tex.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:kitap_al_ver/configuration/costant/images.dart';
import 'package:kitap_al_ver/configuration/costant/theme/text.dart';
import 'package:kitap_al_ver/configuration/costant/theme/text_them.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/auth.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/forget/forget_page.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/lodiverder.dart';
import 'package:kitap_al_ver/tabbar/liquidTabbar.dart';


class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
 void _handleLogin() async {
    // Check if the username and password fields are empty
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      // Show an AlertDialog if any of them is empty
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(AppText.enterUsernamePassword),
        ),
      );
      return; // Terminate the process when an error occurs
    }

    // Continue with the login process if both fields are filled
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
       MaterialPageRoute(builder: (context) =>  LiquidTabBar()),
      );
      // Successful login, you can optionally perform other operations
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException errors
      // ignore: avoid_print
      print(e.code); // Print the error code
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) =>const AlertDialog(
            title: Text(AppText.userNotFound),
          ),
        );
        return;
      }
      if (e.code == 'invalid-email') {
        showDialog(
          context: context,
          builder: (context) =>const  AlertDialog(
            title: Text(AppText.invalide),
          ),
        );
      }
      if (e.code == 'network-request-failed') {
        showDialog(
          context: context,
          builder: (context) =>const  AlertDialog(
            title: Text(AppText.networkError),
          ),
        );
      }

      if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) =>const  AlertDialog(
            title: Text(AppText.wrongPassword),
          ),
        );
        return;
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error: ${e.code}"), // Print the error code
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double mHeight = mediaQueryData.size.height;
    final double mWidth = mediaQueryData.size.width;
    final ThemeData theme = Theme.of(context);

    return Container(
      width: mWidth,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? AppColor.screendart
            : AppColor.screenlight,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: mHeight / 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(
                hintText: AppText.email,
                obscureText: false,
                controller: _usernameController,
                prefixIcon: Image.asset(AppImage.email),
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: AppText.password,
                obscureText: true,
                controller: _passwordController,
                prefixIcon: Image.asset(AppImage.pasword),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgetPage()),
                  );
                },
                child: Text(
                  AppText.forgetText,
                  style: GoogleFonts.playfairDisplay(
                      textStyle: AppTextTheme.login(context)),
                ),
              )
            ],
          ),
           MyButton(
            buttonText: AppText.login,
            onTap: () {
             _handleLogin();
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: mHeight / 50),
            child: const LoginDivider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoogleSignInButton(),
              const SizedBox(width: 16),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AuthPage(isLogin: false)),
              );
            },
            child: Text(
              AppText.register,
              style: GoogleFonts.playfairDisplay(
                  textStyle: AppTextTheme.login(context)),
            ),
          )
        ],
      ),
    );
  }
}