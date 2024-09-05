// ignore_for_file: unused_local_variable, use_super_parameters, annotate_overrides

import 'dart:io';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitap_al_ver/configuration/core/google_button.dart';
import 'package:kitap_al_ver/configuration/core/my_button.dart';
import 'package:kitap_al_ver/configuration/core/my_tex.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:kitap_al_ver/configuration/costant/images.dart';
import 'package:kitap_al_ver/configuration/costant/theme/text.dart';
import 'package:kitap_al_ver/configuration/costant/theme/text_them.dart';
import 'package:kitap_al_ver/pages/firebes_auth.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/auth.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/user_info_page.dart';


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  File? _imageFile;

  void dispose() {
    // Dispose metodu düzenlendi
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPwController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  Future<void> _register(
    BuildContext context, {
    required String email,
    required String password,
    required String passwordConfirm,
    required String username,
    required File profile,
  }) async {
    await _authService.registerUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPwController.text,
      username: _usernameController.text,

      profile:
          _imageFile ?? File(''), // Kullanıcı tarafından seçilen profil resmi
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double mHeight = mediaQueryData.size.height;
    final double mWidth = mediaQueryData.size.width;
    final ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const UserInfoPage(),
              MyTextField(
                hintText: AppText.email,
                obscureText: false,
                controller: _emailController,
                prefixIcon: Image.asset(AppImage.email),
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: AppText.password,
                obscureText: true,
                controller: _passwordController,
                prefixIcon: Image.asset(AppImage.pasword),
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: AppText.password,
                obscureText: true,
                controller: _confirmPwController,
                prefixIcon: Image.asset(AppImage.pasword),
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "USER",
                obscureText: false,
                controller: _usernameController,
                prefixIcon: Image.asset(AppImage.pasword),
              ),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                buttonText: AppText.record,
                onTap: () => _register(
                  context,
                  email: _emailController.text,
                  password: _passwordController.text,
                  passwordConfirm: _confirmPwController.text,
                  username: _usernameController.text,
                  profile: _imageFile ?? File(''),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GoogleSignInButton(),
                  const SizedBox(width: 16),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthPage(isLogin: true)),
                      );
                    },
                    child: Text(
                      AppText.logingo,
                      style: GoogleFonts.playfairDisplay(
                          textStyle: AppTextTheme.login(context)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
