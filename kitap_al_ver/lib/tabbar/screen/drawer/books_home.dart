// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/screnn/widget/imageCarousel.dart';
import 'package:kitap_al_ver/widget/product_Card.dart';

class Books_Home extends StatefulWidget {
  const Books_Home({super.key});

  @override
  State<Books_Home> createState() => _Books_HomeState();
}

class _Books_HomeState extends State<Books_Home> {
  List<String> _imageUrls = []; // Firebase'den alınan fotoğraf URL'leri

  @override
  void initState() {
    super.initState();
    _loadImageUrls();
  }

  Future<void> _loadImageUrls() async {
    try {
      final ListResult result =
          await FirebaseStorage.instance.ref('deneme').listAll();

      final List<String> urls = [];
      for (var ref in result.items) {
        final String url = await ref.getDownloadURL();
        urls.add(url);
      }

      setState(() {
        _imageUrls = urls;
      });
    } catch (e) {
      print('Error loading image URLs: $e');
    }
  }

  Future<List<String>> getPhotoUrls() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('post').get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final url = data['postImage'] as String?;
          if (url != null) {
            return url;
          } else {
            throw Exception('URL is null for a document');
          }
        }).toList();
      } else {
        throw Exception('No documents found');
      }
    } catch (e) {
      print('Error fetching photo URLs: $e');
      return []; // Return an empty list in case of error
    }
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
        FutureBuilder<List<String>>(
          future: getPhotoUrls(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return SliverToBoxAdapter(
                child: Center(child: Text('Error: ${snapshot.error}')),
              );
            } else if (snapshot.hasData) {
              final photoUrls = snapshot.data!;

              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final photoUrl = photoUrls[index];
                    return ProductCard(photoUrl: photoUrl);
                  },
                  childCount: photoUrls.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              );
            } else {
              return SliverToBoxAdapter(
                child: Center(child: Text('No data found')),
              );
            }
          },
        ),
      ],
    );
  }
}
