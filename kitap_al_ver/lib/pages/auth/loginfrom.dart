import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitap_al_ver/components/google_button.dart';
import 'package:kitap_al_ver/components/my_button.dart';
import 'package:kitap_al_ver/pages/widget/core/my_tex.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:kitap_al_ver/pages/widget/theme/text.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/service/firebes_auth.dart';
import 'package:kitap_al_ver/pages/auth/auth_Page.dart';
import 'package:kitap_al_ver/pages/auth/forget_page.dart';
import 'package:kitap_al_ver/pages/auth/lodiverder.dart';
import 'package:kitap_al_ver/utils/images.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  void _handleLogin() {
    _authService.signInWithEmailAndPassword(
      context: context,
      email: _usernameController.text,
      password: _passwordController.text,
    );
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
