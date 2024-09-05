// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';

// ignore: use_key_in_widget_constructors

// ignore: use_key_in_widget_constructors
class BookCategoryOverview extends StatefulWidget {
  // İsim değiştirildi
  @override
  State<BookCategoryOverview> createState() =>
      _BookCategoryOverviewState(); // İsim değiştirildi
}

class _BookCategoryOverviewState extends State<BookCategoryOverview> {
  // İsim değiştirildi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenlight1,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.screenlight1,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Column(
              children: [
                SizedBox(height: 110),
              ],
            ),
          ),
          Container(
            color: AppColor.screenlight1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('TYT-KİTAP', 'assets/images/profile.png',
                      Colors.deepOrange, () {
                    Navigator.of(context).pushNamed('/tababrhome');
                  }),
                  itemDashboard(
                      'AYT-KİTAP', 'assets/images/profile.png', Colors.green,
                      () {
                    Navigator.of(context).pushNamed('/tababrhome');
                  }),
                  itemDashboard(
                      'LGS-KİTAP', 'assets/images/profile.png', Colors.purple,
                      () {
                    Navigator.of(context).pushNamed('/tababrhome');
                  }),
                  itemDashboard(
                      'KPPS-KİTAP', 'assets/images/profile.png', Colors.brown,
                      () {
                    Navigator.of(context).pushNamed('/tababrhome');
                  }),
                  itemDashboard(
                      'ALES-KİTAP', 'assets/images/profile.png', Colors.indigo,
                      () {
                    Navigator.of(context).pushNamed('/tababrhome');
                  }),
                  itemDashboard(
                      'TUS-KİTAP', 'assets/images/profile.png', Colors.teal,
                      () {
                    Navigator.of(context).pushNamed('/tababrhome');
                  }),
                  itemDashboard('YDS', 'assets/images/profile.png', Colors.blue,
                      () {
                    Navigator.of(context).pushNamed('/tababrhome');
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget itemDashboard(String title, String imagePath, Color background,
      VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Theme.of(context).primaryColor.withOpacity(.2),
        elevation: 5,
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              imagePath,
              color: Colors.white,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            style: TextStyle(color: Colors.amber),
          ),
        ],
      ),
    );
  }
}
