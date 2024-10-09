// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<String> imageUrls = [];
  final ImagePicker _picker = ImagePicker();

  Future<List<String>> loadImageUrls() async {
    try {
      final ListResult result =
          await FirebaseStorage.instance.ref('deneme').listAll();
      final List<String> urls = [];
      for (var ref in result.items) {
        final String url = await ref.getDownloadURL();
        urls.add(url);
      }
      return urls;
    } catch (e) {
      print('Error loading image URLs: $e');
      return [];
    }
  }

  void _loadImages() async {
    final urls = await loadImageUrls();
    setState(() {
      imageUrls = urls;
    });
  }

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Dosya adını belirle
      final fileName = image.name;

      // Firebase Storage'a yükle
      final storageRef = FirebaseStorage.instance.ref('deneme/$fileName');
      await storageRef.putFile(File(image.path));

      // Yükleme tamamlandıktan sonra URL'yi al
      final String downloadUrl = await storageRef.getDownloadURL();
      print('Yüklenen resmin URL\'si: $downloadUrl');

      // Yeni URL'yi imageUrls listesine ekle
      setState(() {
        imageUrls.add(downloadUrl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _loadImages,
            child: const Text('Görüntüleri Yükle'),
          ),
          ElevatedButton(
            onPressed: _uploadImage,
            child: const Text('Fotoğraf Yükle'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(imageUrls[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
