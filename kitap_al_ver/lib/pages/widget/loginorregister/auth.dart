//arka plan görünümü

//Ama onbordingten sonra Authpage cahrılıyor
//loginfrom  ile regidter burda

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:kitap_al_ver/configuration/costant/images.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/loginfrom.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/register_from.dart';




class AuthPage extends StatelessWidget {
  final bool isLogin;
  final void Function()? onTap;

  AuthPage({super.key, required this.isLogin, this.onTap});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double mHeight = mediaQueryData.size.height;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? AppColor.darttBg
                    : AppColor.lightBg,
              ),
              child: Column(
                children: [
                  Container(
                    height: mHeight / 5,
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? AppColor.screendart
                          : AppColor.screenlight,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.elliptical(250, 50),
                        bottomRight: Radius.elliptical(250, 50),
                      ),
                      image: const DecorationImage(
                        image: AssetImage(AppImage.logo),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mHeight -
                        (mHeight / 11) -
                        mediaQueryData.padding.top -
                        mediaQueryData.padding.bottom,
                    child: Transform.translate(
                      offset: const Offset(0, -35),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: isLogin
                            ? LoginFrom(onTap: onTap)
                            : RegisterPage(onTap: onTap),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
