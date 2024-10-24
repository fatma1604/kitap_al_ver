// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/my_button.dart';
import 'package:kitap_al_ver/pages/widget/core/my_tex.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:kitap_al_ver/pages/widget/theme/text.dart';
import 'package:kitap_al_ver/service/firebes_auth.dart';
import 'package:kitap_al_ver/utils/images.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  final _emailController = TextEditingController();
  final FirebaseAuthService _authService =
      FirebaseAuthService(); 

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetButtonPressed() async {
    await _authService.handlePasswordReset(
      context: context,
      email: _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
        ),
        child: Card(
          color: theme.brightness == Brightness.dark
              ? AppColor.screendart
              : AppColor.screenlight,
          shadowColor: Colors.black,
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {}, icon: Image.asset(AppImage.profil)),
                MyTextField(
                  prefixIcon: Image.asset(AppImage.email),
                  hintText: AppText.email,
                  controller: _emailController,
                ),
                const SizedBox(height: 15),
                MyButton(
                  buttonText: AppText.approval,
                  onTap: _handleResetButtonPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
