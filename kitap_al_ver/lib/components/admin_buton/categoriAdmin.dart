// ignore_for_file: avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/service/categry.dart';


class CategoryAdmin extends StatelessWidget {
  const CategoryAdmin({super.key});

  Future<void> addCategoryToFirestore(CategoryModel category) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('categories').add({
        'categoryname': category.categoryname,
        'images': category.images,
        'classes': category.classes,
        'types': category.types,
        'subjects': category.subjects,
        'durum': category.durum,
        'history': category.history,
      });
      print('Category ${category.categoryname} added successfully');
    } catch (e) {
      print('Error adding category ${category.categoryname}: $e');
    }
  }

  Future<void> addAllCategories() async {
    for (var category in kategory) {
      await addCategoryToFirestore(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await addAllCategories();
          },
          child: const Text('Add All Categories to Firestore'),
        ),
      ),
    );
  }
}
