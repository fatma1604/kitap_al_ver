// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitap_al_ver/ks.dart';
import 'package:kitap_al_ver/pages/widget/core/newrow.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/utils/color.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName ?? 'User';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        theme.brightness == Brightness.dark ? AppColor.white : AppColor.black;

    final backgroundColor = theme.brightness == Brightness.dark
        ? AppColor.screendart
        : AppColor.screenlight;

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(width: 10),
                Text(
                  _userName,
                  style: GoogleFonts.playfairDisplay(
                    textStyle:
                        AppTextTheme.login(context).copyWith(color: textColor),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                NewRow(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PostsScreen(bookTitle: 'Tyt Kitap'),
                      ),
                    );
                  },
                  text: 'Tyt Kitap',
                  icon: Icons.home,
                  textColor: textColor,
                ),
                const SizedBox(height: 20),
                NewRow(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PostsScreen(bookTitle: 'AYT kitap'),
                      ),
                    );
                  },
                  text: 'AYT kitap',
                  icon: Icons.person_outline,
                  textColor: textColor,
                ),
                const SizedBox(height: 20),
                NewRow(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PostsScreen(bookTitle: 'Lgs kitap'),
                      ),
                    );
                  },
                  text: 'Lgs kitap',
                  icon: Icons.settings_brightness_rounded,
                  textColor: textColor,
                ),
                const SizedBox(height: 20),
                NewRow(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PostsScreen(bookTitle: 'TUS'),
                      ),
                    );
                  },
                  text: 'Tus kitap',
                  icon: Icons.ac_unit_rounded,
                  textColor: textColor,
                ),
                const SizedBox(height: 20),
                NewRow(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            PostsScreen(bookTitle: 'Paylaşalım'),
                      ),
                    );
                  },
                  text: 'Paylaşalım',
                  icon: Icons.access_alarm_outlined,
                  textColor: textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
