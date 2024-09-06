import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/model/bilgi_model.dart';

class InformationFormScreen extends StatefulWidget {
  @override
  _InformationFormScreenState createState() => _InformationFormScreenState();
}

class _InformationFormScreenState extends State<InformationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedClass;
  String? _selectedUsageStatus;
  String? _selectedType;
  String? _selectedSubject;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCoder = false; // Indicates if the user is a code
  Future<void> _checkUserRole() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        setState(() {
          _isCoder = userDoc['role'] == 'coder'; // Assuming role field exists
        });
      }
    } catch (e) {
      print('Error fetching user role: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Bilgi Ekleme',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'İlan Başlığı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
                /* onChanged: (value) {
                  _title = value;
                },*/
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Sınıf Seçimi',
                  border: OutlineInputBorder(),
                ),
                value: _selectedClass,
                items: ['Sınıf 9', 'Sınıf 10', 'Sınıf 11', 'Sınıf 12']
                    .map((classItem) {
                  return DropdownMenuItem(
                    value: classItem,
                    child: Text(classItem),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedClass = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Kullanım Durumu',
                  border: OutlineInputBorder(),
                ),
                value: _selectedUsageStatus,
                items: ['Az Kullanılmış', 'İkinci El', 'Yeni'].map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUsageStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'TÜR',
                  border: OutlineInputBorder(),
                ),
                value: _selectedType,
                items: ['DENEME', 'SET', 'TEST'].map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'DERS',
                  border: OutlineInputBorder(),
                ),
                value: _selectedSubject,
                items: [
                  'BİYOLOJİ',
                  'COĞRAFYA',
                  'EDEBİYAT-DİLBİLGİSİ',
                  'FELSEFE',
                  'FİZİK',
                  'GEOMETRİ',
                  'KİMYA',
                  'PARAGRAF',
                  'TARİH',
                  'TÜRKÇE'
                ].map((subject) {
                  return DropdownMenuItem(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Bu alan zorunludur';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ek Bilgi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  /*   _additionalInfo = value;*/
                },
              ),
              SizedBox(height: 32.h),
              /*  ElevatedButton(
                onPressed: _class(),
                child: Text('Devam Et'),
              ),*/

              ElevatedButton(onPressed: _lesson, child: Text("veriat"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _class() async {
    try {
      final categoryCollection = _firestore.collection('Class');
      final querySnapshot = await categoryCollection.get();

      if (querySnapshot.docs.isEmpty) {
        // Iterate through the 'bilgi' list (assuming it's a predefined list)
        for (var information in bilgi) {
          // Assuming 'information.sinif' is a list and 'sinif' is a function to transform or map the items
          List<dynamic> categoryNames =
              information.sinif.map((sinif) => sinif).toList();

          // Create a new document in Firestore
          DocumentReference docRef = categoryCollection.doc();
          await docRef.set({
            'category_name': categoryNames,
            'category_uid': docRef.id,
          });
        }
      }
    } catch (e) {
      // Print the error for debugging purposes
      print('Error: $e');
      // Optionally, you can also show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }

  Future<void> _case() async {
    try {
      final categoryCollection = _firestore.collection('Case');
      final querySnapshot = await categoryCollection.get();

      // Check if the collection is empty
      if (querySnapshot.docs.isEmpty) {
        // Iterate through the 'bilgi' list (assuming it's a predefined list)
        for (var caseItem in bilgi) {
          // Assuming 'caseItem.durum' is a list that you want to store
          List<String> durumList =
              caseItem.durum.map((durum) => durum).toList();

          // Create a new document in Firestore
          DocumentReference docRef = categoryCollection.doc();
          await docRef.set({
            'durum': durumList,
            'durum_uid': docRef.id,
          });
        }

        // Notify success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veriler başarıyla eklendi.')),
        );
      } else {
        // Notify if the collection is not empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Koleksiyon zaten dolu.')),
        );
      }
    } catch (e) {
      // Print the error for debugging purposes
      print('Error: $e');
      // Optionally, you can also show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }

  Future<void> _type() async {
    try {
      final categoryCollection = _firestore.collection('Type');
      final querySnapshot = await categoryCollection.get();

      // Check if the collection is empty
      if (querySnapshot.docs.isEmpty) {
        // Iterate through the 'bilgi' list (assuming it's a predefined list)
        for (var type in bilgi) {
          // Assuming 'caseItem.durum' is a list that you want to store
          List<String> turlist = type.tur.map((tur) => tur).toList();

          // Create a new document in Firestore
          DocumentReference docRef = categoryCollection.doc();
          await docRef.set({
            'type': turlist,
            'type_uid': docRef.id,
          });
        }

        // Notify success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veriler başarıyla eklendi.')),
        );
      } else {
        // Notify if the collection is not empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Koleksiyon zaten dolu.')),
        );
      }
    } catch (e) {
      // Print the error for debugging purposes
      print('Error: $e');
      // Optionally, you can also show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }

  Future<void> _lesson() async {
    try {
      final categoryCollection = _firestore.collection('lesson');
      final querySnapshot = await categoryCollection.get();

      // Check if the collection is empty
      if (querySnapshot.docs.isEmpty) {
        // Iterate through the 'bilgi' list (assuming it's a predefined list)
        for (var lessons in bilgi) {
          // Assuming 'caseItem.durum' is a list that you want to store
          List<String> lessonsList = lessons.durum.map((ders) => ders).toList();

          // Create a new document in Firestore
          DocumentReference docRef = categoryCollection.doc();
          await docRef.set({
            'lesons': lessonsList,
            'type_uid': docRef.id,
          });
        }

        // Notify success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veriler başarıyla eklendi.')),
        );
      } else {
        // Notify if the collection is not empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Koleksiyon zaten dolu.')),
        );
      }
    } catch (e) {
      // Print the error for debugging purposes
      print('Error: $e');
      // Optionally, you can also show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }
}
