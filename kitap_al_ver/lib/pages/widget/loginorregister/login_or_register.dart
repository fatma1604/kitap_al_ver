
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/loginfrom.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/register_from.dart';



class LoginOrRegister extends StatefulWidget {
  // ignore: use_super_parameters
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginFrom(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
