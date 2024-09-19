// ignore_for_file: file_names, use_build_context_synchronously, avoid_print, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/model/bilgi_model.dart';


// FirebaseFirestore ve bilgi değişkenlerini tanımlayın
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
List<BilgiModel> bilgi = []; // YourDataType uygun veri tipinizle değiştirilmelidir

Future<void> _addDataToCollection(BuildContext context, String collectionName, Function(dynamic) mapFunction, String fieldName) async {
  try {
    final categoryCollection = _firestore.collection(collectionName);
    final querySnapshot = await categoryCollection.get();

    if (querySnapshot.docs.isEmpty) {
      for (var item in bilgi) {
        List<dynamic> mappedList = mapFunction(item);

        DocumentReference docRef = categoryCollection.doc();
        await docRef.set({
          fieldName: mappedList,
          '${fieldName}_uid': docRef.id,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veriler başarıyla eklendi.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Koleksiyon zaten dolu.')),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bir hata oluştu: $e')),
    );
  }
}

Future<void> _class(BuildContext context) async {
  await _addDataToCollection(
    context,
    'Class',
    (information) => information.sinif.map((sinif) => sinif).toList(),
    'category_name',
  );
}

Future<void> _case(BuildContext context) async {
  await _addDataToCollection(
    context,
    'Case',
    (caseItem) => caseItem.durum.map((durum) => durum).toList(),
    'durum',
  );
}

Future<void> type(BuildContext context) async {
  await _addDataToCollection(
    context,
    'Type',
    (type) => type.tur.map((tur) => tur).toList(),
    'type',
  );
}

Future<void> lesson(BuildContext context) async {
  await _addDataToCollection(
    context,
    'lesson',
    (lessons) => lessons.ders.map((ders) => ders).toList(),
    'lessons',
  );
}
