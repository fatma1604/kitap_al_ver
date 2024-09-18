import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitap_al_ver/configuration/core/newrow.dart';
import 'package:kitap_al_ver/configuration/costant/theme/text_them.dart';

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
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Container(
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
                  onPressed: () {},
                  text: 'Anasayfa',
                  icon: Icons.home,
                  textColor: textColor, // Buton için metin rengi
                ),
                const SizedBox(height: 20),
                NewRow(
                  onPressed: () {},
                  text: 'Profil',
                  icon: Icons.person_outline,
                  textColor: textColor,
                ),
                const SizedBox(height: 20),
                NewRow(
                  onPressed: () {},
                  text: 'Ayarlar',
                  icon: Icons.settings_brightness_rounded,
                  textColor: textColor,
                ),
                const SizedBox(height: 20),
                NewRow(
                  onPressed: () {},
                  text: 'Alışverişlerim',
                  icon: Icons.ac_unit_rounded,
                  textColor: textColor,
                ),
                const SizedBox(height: 20),
                NewRow(
                  onPressed: () {},
                  text: 'Paylaşalım',
                  icon: Icons.access_alarm_outlined,
                  textColor: textColor,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.cancel,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/home");
                  },
                  child: Text(
                    "Çıkış",
                    style: GoogleFonts.playfairDisplay(
                      textStyle: AppTextTheme.login(context)
                          .copyWith(color: textColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
