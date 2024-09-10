/*import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/widget/product_Card.dart';

class PhotoGalleryScreen extends StatefulWidget {
  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadImageUrls();
  }

  Future<void> _loadImageUrls() async {
    try {
      final ListResult result = await FirebaseStorage.instance.ref('your-folder').listAll();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Gallery'),
      ),
      body: _imageUrls.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return ProductCard(post: _imageUrls[index]);
              },
            ),
    );
  }
}
*/