// ignore_for_file: unused_import, library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitap_al_ver/configuration/core/newrow.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
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
    return Container(
      color: AppColor.screenlight1,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
               
                const SizedBox(
                  width: 10,
                ),
                Text(  _userName,
                    style: GoogleFonts.playfairDisplay(
                        textStyle: AppTextTheme.login(context))),
              ],
            ),
            Column(
              children: <Widget>[
                NewRow(
                  onPressed: () {},
                  text: 'Anasayfa',
                  icon: Icons.home,
                ),
                const SizedBox(
                  height: 20,
                ),
                NewRow(
                  onPressed: () {},
                  text: 'Profile',
                  icon: Icons.person_outline,
                ),
                const SizedBox(
                  height: 20,
                ),
                NewRow(
                  onPressed: () {},
                  text: 'Ayarlar',
                  icon: Icons.settings_brightness_rounded,
                ),
                const SizedBox(
                  height: 20,
                ),
                NewRow(
                  onPressed: () {},
                  text: 'Alışverişlerim',
                  icon: Icons.ac_unit_rounded,
                ),
                const SizedBox(
                  height: 20,
                ),
                NewRow(
                  onPressed: () {},
                  text: 'Paylaşalım',
                  icon: Icons.access_alarm_outlined,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.cancel,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/home");
                  },
                  child: Text("Çıkış",
                      style: GoogleFonts.playfairDisplay(
                          textStyle: AppTextTheme.login(context))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
