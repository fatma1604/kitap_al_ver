// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/service/categry.dart';
import 'package:kitap_al_ver/pages/auth/information.dart';
import 'package:kitap_al_ver/service/for%C4%B1mHelper.dart';
import 'package:kitap_al_ver/utils/color.dart';


class BookCategoryOverview extends StatefulWidget {
  @override
  State<BookCategoryOverview> createState() => _BookCategoryOverviewState();
}

class _BookCategoryOverviewState extends State<BookCategoryOverview> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCoder = false; 
  final List<CategoryModel> kategory = []; 

  @override
  void initState() {
    super.initState();
    FormHelpers.checkUserRole(_auth, _firestore, (isCoder) {
      setState(() {
        _isCoder = isCoder;
      });
    });
    FormHelpers.checkAndSendDataToFirestore(_firestore, kategory);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColor.screendart : AppColor.screenlight,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColor.screendart : AppColor.screenlight,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  if (_isCoder) 
                    ElevatedButton(
                      onPressed: () {
                        FormHelpers.checkAndSendDataToFirestore(
                            _firestore, kategory);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? AppColor.buttondart
                            : AppColor.buttonlight,
                      ),
                      child: const Text(
                        'Veriyi Gönder',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              color: isDarkMode ? AppColor.screendart : AppColor.screenlight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200)),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('categories').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('Kategoriler bulunamadı.'));
                    }

                    final categories = snapshot.data!.docs;

                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final categoryData =
                            categories[index].data() as Map<String, dynamic>;
                        final title =
                            categoryData['categoryname'] ?? 'No Title';
                        final imageUrl =
                            categoryData['images'] ?? "assets/images/fatma.png";
                        final colorValues = List<int>.from(
                            categoryData['colors'] ??
                                [Colors.grey.value]);
                        final color = Color(colorValues.isNotEmpty
                            ? colorValues[0]
                            : Colors.grey.value);
                        final categoryModel = CategoryModel(
                          categoryname: title,
                          images: imageUrl,
                          classes:
                              List<String>.from(categoryData['classes'] ?? []),
                          types: List<String>.from(categoryData['types'] ?? []),
                          subjects:
                              List<String>.from(categoryData['subjects'] ?? []),
                          durum: List<String>.from(categoryData['durum'] ?? []),
                          history:
                              List<String>.from(categoryData['history'] ?? []),
                        );

                        return itemDashboard(
                          title,
                          imageUrl,
                          color,
                          () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Information(category: categoryModel)),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
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
              
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 80,
                height: 80, 
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
