// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:kitap_al_ver/configuration/costant/images.dart';
import 'package:kitap_al_ver/models/kategorymodel.dart';

import 'package:kitap_al_ver/service/for%C4%B1mHelper.dart';
import 'package:kitap_al_ver/pages/auth/information.dart';

class BookCategoryOverview extends StatefulWidget {
  @override
  State<BookCategoryOverview> createState() => _BookCategoryOverviewState();
}

class _BookCategoryOverviewState extends State<BookCategoryOverview> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCoder = false; // Indicates if the user is a coder
  final List<Kategorymodel> kategory = []; // Add the actual initialization here

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
    return Scaffold(
      backgroundColor: AppColor.screenlight1,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColor.screenlight1,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  if (_isCoder) // Conditionally show the button
                    ElevatedButton(
                      onPressed: () {
                        FormHelpers.checkAndSendDataToFirestore(
                            _firestore, kategory);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
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
              color: AppColor.screenlight1,
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
                            categoryData['category_name'] ?? 'No Title';
                        final imageUrl =
                            categoryData['image_url'] ?? AppImage.profil;
                        final colorValues = List<int>.from(
                            categoryData['colors'] ??
                                [Colors.grey.value]); // Default color
                        final color = Color(colorValues.isNotEmpty
                            ? colorValues[0]
                            : Colors.grey.value);

                        return itemDashboard(
                          title,
                          imageUrl,
                          color,
                          () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      InformationFormScreen()),
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
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
