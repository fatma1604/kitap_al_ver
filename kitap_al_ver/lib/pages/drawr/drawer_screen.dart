import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> _categories = []; // List to hold categories
  Map<String, dynamic>? photoData; // Define photoData

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _fetchCategories(); // Fetch categories
  }

  Future<void> _loadUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName = user.displayName ?? 'User';
      });
    }
  }

  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        _categories = snapshot.docs
            .map((doc) => doc['categoryname'] as String)
            .toList(); // Get category names
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Fetch photo data if needed, or set it directly here for demo purposes
  void _setPhotoData() {
    photoData = {
      'postImage': 'https://example.com/image.jpg', // Example image URL
      'title': 'Sample Title',
      'type': 'Sample Genre',
      'postUid': 'samplePostUid',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor =
        theme.brightness == Brightness.dark ? AppColor.white : AppColor.black;
    final backgroundColor = theme.brightness == Brightness.dark
        ? AppColor.screendart
        : AppColor.screenlight;

    // Set the photo data here for demonstration purposes
    _setPhotoData();

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
              children: _categories.map((category) {
                return Column(
                  children: <Widget>[
                    NewRow(
                      onPressed: () {
                        if (photoData != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BooksScreen(   categoryTitle: category,),
                             
                            
                            ),
                          );
                        }
                      },
                      text: category, // Category name
                      icon: Icons.category, // Icon
                      textColor: textColor,
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
