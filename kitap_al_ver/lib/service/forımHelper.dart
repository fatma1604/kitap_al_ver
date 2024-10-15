

// ignore_for_file: empty_catches, use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/service/categry.dart';
import 'package:kitap_al_ver/pages/home/galleripage.dart';
import 'package:uuid/uuid.dart';

class FormHelpers {
  static Future<void> navigateToGallery(
      BuildContext context, Function(List<String>) onImagesSelected) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Galleripage(initialImage: null),
      ),
    );

    if (result != null && result is List<String>) {
      onImagesSelected(result); 
    }
  }

 
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
  required String category, 
}) async {
  if (formKey.currentState!.validate()) {
    try {
      User? currentUser = auth.currentUser;
      String username = currentUser?.displayName ?? 'Bilgi Yok';
      String profilePhotoUrl = currentUser?.photoURL ?? '';
      String uid = const Uuid().v4();

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
        'profilePhotoUrl': profilePhotoUrl,
        'category': category, 
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bilgiler başarıyla kaydedildi!')),
      );

      Navigator.pushNamed(context, '/liquidTab');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bilgileri kaydederken bir hata oluştu!')),
      );
    }
  }
}


  
  static Future<void> checkUserRole(FirebaseAuth auth,
      FirebaseFirestore firestore, Function(bool) onRoleChecked) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(user.uid).get();
        onRoleChecked(
            userDoc['role'] == 'coder'); 
      }
    } catch (e) {
    }
  }

 



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
           
          });
        }
      }
    } catch (e) {
    }
  }

  
}
