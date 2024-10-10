// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

import 'package:kitap_al_ver/service/firebes_post.dart';
import 'package:kitap_al_ver/pages/misc/imageCarousel.dart';
import 'package:kitap_al_ver/pages/product/product_Card.dart';
import 'package:kitap_al_ver/utils/images.dart';

class Books_Home extends StatefulWidget {
  const Books_Home({super.key});

  @override
  State<Books_Home> createState() => _Books_HomeState();
}

class _Books_HomeState extends State<Books_Home> {
  List<String> _imageUrls = []; 

  @override
  void initState() {
    super.initState();
    loadImageUrls();
  }

  Future<void> loadImageUrls() async {
    final urls = await FirebasePostServis().loadImageUrls();
    setState(() {
      _imageUrls = urls;
    });
  }

  Future<List<Map<String, dynamic>>> getPhotoUrls() async {
    return await FirebasePostServis().getPhotoUrls();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImageCarousel(
              imageUrls: _imageUrls,
            ),
          ),
        ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: getPhotoUrls(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return SliverToBoxAdapter(
                child: Center(child: Text('Error: ${snapshot.error}')),
              );
            } else if (snapshot.hasData) {
              final photoDataList = snapshot.data!;
              if (photoDataList.isEmpty) {
                
                return SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppImage.books, 
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'RESİM ATMAYA NE DERSİN ',
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final photoData = photoDataList[index];
                    return ProductCard(
                        photoUrl: photoData['postImage'],
                        title: photoData['title'],
                        genre: photoData['type'],
                        postUid: photoData['postUid']);
                  },
                  childCount: photoDataList.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Center(child: Text('No data found')),
              );
            }
          },
        ),
      ],
    );
  }
}