import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitap_al_ver/pages/drawr/drawercategory.dart';
import 'package:kitap_al_ver/pages/widget/core/newrow.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/service/firebes_post.dart';
import 'package:kitap_al_ver/utils/color.dart';


class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String _userName = '';
  List<String> _categories = [];
  Map<String, dynamic>? photoData;

  final FirebasePostServis _firebaseService = FirebasePostServis(); // Create an instance of FirebaseService

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _fetchCategories();
  }

  Future<void> _loadUserName() async {
    String? userName = await _firebaseService.loadUserName();
    setState(() {
      _userName = userName ?? 'User';
    });
  }

  Future<void> _fetchCategories() async {
    List<String> categories = await _firebaseService.fetchCategories();
    setState(() {
      _categories = categories;
    });
  }

  void _setPhotoData() {
    photoData = {
      'postImage': 'https://example.com/image.jpg',
      'title': 'Sample Title',
      'type': 'Sample Genre',
      'postUid': 'samplePostUid',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.dark ? AppColor.white : AppColor.black;
    final backgroundColor = theme.brightness == Brightness.dark ? AppColor.screendart : AppColor.screenlight;

    _setPhotoData(); // Set photo data for demo purposes

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildUserName(textColor),
          _buildCategoryList(textColor),
        ],
      ),
    );
  }

  Widget _buildUserName(Color textColor) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 10),
        Text(
          _userName,
          style: GoogleFonts.playfairDisplay(
            textStyle: AppTextTheme.login(context).copyWith(color: textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList(Color textColor) {
    return Column(
      children: _categories.map((category) {
        return Column(
          children: <Widget>[
            NewRow(
              onPressed: () {
                if (photoData != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DrawerCategoryScreen(categoryTitle: category),
                    ),
                  );
                }
              },
              text: category,
              icon: Icons.category,
              textColor: textColor,
            ),
            const SizedBox(height: 20),
          ],
        );
      }).toList(),
    );
  }
}
