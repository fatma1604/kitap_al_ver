// form_helpers.dart
// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/categry.dart';
import 'package:kitap_al_ver/components/tabbar/liquidTabbar.dart';
import 'package:kitap_al_ver/pages/home/galleripage.dart';
import 'package:uuid/uuid.dart';

class FormHelpers {
  // Navigate to gallery and get selected images
  static Future<void> navigateToGallery(
      BuildContext context, Function(List<String>) onImagesSelected) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Galleripage(initialImage: null),
      ),
    );

    if (result != null && result is List<String>) {
      onImagesSelected(result); // Pass the selected images back
    }
  }

  // form_helpers.dart
static Future<void> submitForm({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required String title,
  required String? selectedClass,
  required String? selectedUsageStatus,
  required String? selectedType,
  required String? selectedSubject,
  required String additionalInfo,
  required String description,
  required List<String>? postImages,
  required List<String> like,
  required FirebaseAuth auth,
  required FirebaseFirestore firestore,
  required String profilePhotoUrl, // Profil fotoğrafı URL'si parametresi eklendi
}) async {
  if (formKey.currentState!.validate()) {
    try {
      User? currentUser = auth.currentUser;
      String username = currentUser?.displayName ?? 'Bilgi Yok';
      String uid = Uuid().v4();

      await firestore.collection('post').doc(uid).set({
        'title': title.isNotEmpty ? title : 'Başlık Yok',
        'class': selectedClass,
        'usageStatus': selectedUsageStatus,
        'type': selectedType,
        'subject': selectedSubject,
        'additionalInfo': additionalInfo.isNotEmpty ? additionalInfo : 'Ek Bilgi Yok',
        'createdAt': FieldValue.serverTimestamp(),
        'user_uid': auth.currentUser!.uid,
        'post_uid': uid,
        'postImages': postImages,
        'like': like,
        'username': username,
        'description': description,
        'profilePhotoUrl': profilePhotoUrl, // Profil fotoğrafı URL'sini ekliyoruz
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bilgiler başarıyla kaydedildi!')),
      );

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LiquidTabBar()));
    } catch (e) {
      print('Error saving information: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bilgileri kaydederken bir hata oluştu!')),
      );
    }
  }
}


  // Check if the user has the 'coder' role
  static Future<void> checkUserRole(FirebaseAuth auth,
      FirebaseFirestore firestore, Function(bool) onRoleChecked) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(user.uid).get();
        onRoleChecked(
            userDoc['role'] == 'coder'); // Assuming 'role' field exists
      }
    } catch (e) {
      print('Error fetching user role: $e');
    }
  }

  // Fetch data from Firestore collections
  static Future<void> fetchData({
    required FirebaseFirestore firestore,
    required Function(List<String>) onClassesFetched,
    required Function(List<String>) onUsageStatusesFetched,
    required Function(List<String>) onTypesFetched,
    required Function(List<String>) onSubjectsFetched,
  }) async {
    try {
      final classSnapshot = await firestore.collection('Class').get();
      onClassesFetched(classSnapshot.docs
          .expand((doc) =>
              (doc['category_name'] as List<dynamic>).map((e) => e.toString()))
          .toList());

      final usageStatusSnapshot = await firestore.collection('Case').get();
      onUsageStatusesFetched(usageStatusSnapshot.docs
          .expand(
              (doc) => (doc['durum'] as List<dynamic>).map((e) => e.toString()))
          .toList());

      final typeSnapshot = await firestore.collection('Type').get();
      onTypesFetched(typeSnapshot.docs
          .expand(
              (doc) => (doc['type'] as List<dynamic>).map((e) => e.toString()))
          .toList());

      final subjectSnapshot = await firestore.collection('Lesson').get();
      onSubjectsFetched(subjectSnapshot.docs
          .expand((doc) =>
              (doc['lesons'] as List<dynamic>).map((e) => e.toString()))
          .toList());
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error as needed
    }
  }

  // Check and send data to Firestore if not already present
  static Future<void> checkAndSendDataToFirestore(
      FirebaseFirestore firestore, List<CategoryModel> kategory) async {
    try {
      final categoryCollection = firestore.collection('categories');
      final querySnapshot = await categoryCollection.get();

      if (querySnapshot.docs.isEmpty) {
        for (var category in kategory) {
          DocumentReference docRef = categoryCollection.doc();
          await docRef.set({
            'category_name': category.categoryname,
            'category_uid': docRef.id,
            'image_url': category.images,
            'colors': category.colors
                .map((color) => color.value)
                .toList(), // Save colors as integers
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
