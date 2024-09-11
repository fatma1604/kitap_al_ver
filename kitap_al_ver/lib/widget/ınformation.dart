import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/model/bilgi_model.dart';
import 'package:kitap_al_ver/mykonum.dart';
import 'package:kitap_al_ver/pages/data/firebes_post.dart';
import 'package:kitap_al_ver/post/galleripage.dart';
import 'package:uuid/uuid.dart';

class InformationFormScreen extends StatefulWidget {
  @override
  _InformationFormScreenState createState() => _InformationFormScreenState();
}

class _InformationFormScreenState extends State<InformationFormScreen> {
  bool islooding = false;

  final _formKey = GlobalKey<FormState>();
  String? _selectedClass;
  String? _selectedUsageStatus;
  String? _selectedType;
  String? _selectedSubjec;
  String? _selectedSubject;
  List<String>? _postImages; // Changed from String? to List<String>?
  List<String> _classes = [];
  List<String> _usageStatuses = [];
  List<String> _types = [];
  List<String> _subjects = [];
  List<String> _like = [];
  var uid = Uuid().v4();
  String _title = '';
  String _additionalInfo = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCoder = false; // Indicates if the user is a coder

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the screen is initialized
    _checkUserRole();
    // UUID oluştur
  }

  Future<void> _navigateToGallery() async {
    // Navigate to gallery and await result
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Galleripage(initialImage: null),
      ),
    );

    // Check if result is not null and is a list of image URLs
    if (result != null && result is List<String>) {
      setState(() {
        _postImages = result; // Store the list of image URLs
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Firestore'da bir belge oluştur ve verileri kaydet
        await FirebaseFirestore.instance.collection('post').doc(uid).set({
          'title': _title.isNotEmpty ? _title : 'Başlık Yok',
          'class': _selectedClass,
          'usageStatus': _selectedUsageStatus,
          'type': _selectedType,
          'subject': _selectedSubjec,
          'additionalInfo': _additionalInfo.isNotEmpty ? _additionalInfo : 'Ek Bilgi Yok',
          'createdAt': FieldValue.serverTimestamp(),
          'user_uid': _auth.currentUser!.uid,
          'post_uid': uid, // UUID'yi veriye dahil et
          'postImages': _postImages, // Save the list of image URLs
          'link': _like,
        });

        // Başarılı olduğunda bir mesaj göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bilgiler başarıyla kaydedildi!')),
        );

        // Bir sonraki ekrana git
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mykonum()));
      } catch (e) {
        print('Error saving information: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bilgileri kaydederken bir hata oluştu!')),
        );
      }
    }
  }

  // Other methods and widget build implementation would go here...



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

  Future<void> _fetchData() async {
    try {
      final classSnapshot = await _firestore.collection('Class').get();
      print('Classes: ${classSnapshot.docs.map((doc) => doc.data()).toList()}');
      setState(() {
        _classes = classSnapshot.docs
            .expand((doc) => (doc['category_name'] as List<dynamic>)
                .map((e) => e.toString()))
            .toList();
      });

      final usageStatusSnapshot = await _firestore.collection('Case').get();
      print(
          'Usage Statuses: ${usageStatusSnapshot.docs.map((doc) => doc.data()).toList()}');
      setState(() {
        _usageStatuses = usageStatusSnapshot.docs
            .expand((doc) =>
                (doc['durum'] as List<dynamic>).map((e) => e.toString()))
            .toList();
      });

      final typeSnapshot = await _firestore.collection('Type').get();
      print('Types: ${typeSnapshot.docs.map((doc) => doc.data()).toList()}');
      setState(() {
        _types = typeSnapshot.docs
            .expand((doc) =>
                (doc['type'] as List<dynamic>).map((e) => e.toString()))
            .toList();
      });

      final subjectSnapshot = await _firestore.collection('Lesson').get();
      print(
          'Subjects: ${subjectSnapshot.docs.map((doc) => doc.data()).toList()}');
      setState(() {
        _subjects = subjectSnapshot.docs
            .expand((doc) => (doc['lesons'] as List<dynamic>)
                .map((e) => e.toString())) // Adjust field name here
            .toList();
      });
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Bilgi Ekleme',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: _navigateToGallery, // Call gallery
            ),
          ],
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
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Sınıf Seçimi',
                  border: OutlineInputBorder(),
                ),
                value: _selectedClass,
                items: _classes.map((classItem) {
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
                items: _usageStatuses.map((status) {
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
                items: _types.map((type) {
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
                value: _selectedSubjec,
                items: _subjects.map((subject) {
                  return DropdownMenuItem(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSubjec = value;
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
                  _additionalInfo = value;
                },
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Devam Et'),
              )
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
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }

  Future<void> _case() async {
    try {
      final categoryCollection = _firestore.collection('Case');
      final querySnapshot = await categoryCollection.get();

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

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veriler başarıyla eklendi.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Koleksiyon zaten dolu.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }

  Future<void> _type() async {
    try {
      final categoryCollection = _firestore.collection('Type');
      final querySnapshot = await categoryCollection.get();

      if (querySnapshot.docs.isEmpty) {
        for (var type in bilgi) {
          List<String> turlist = type.tur.map((tur) => tur).toList();

          DocumentReference docRef = categoryCollection.doc();
          await docRef.set({
            'type': turlist,
            'type_uid': docRef.id,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veriler başarıyla eklendi.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Koleksiyon zaten dolu.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }

  Future<void> _lesson() async {
    try {
      final categoryCollection = _firestore.collection('lesson');
      final querySnapshot = await categoryCollection.get();

      if (querySnapshot.docs.isEmpty) {
        for (var lessons in bilgi) {
          List<String> lessonsList = lessons.ders.map((ders) => ders).toList();

          DocumentReference docRef = categoryCollection.doc();
          await docRef.set({
            'lessons': lessonsList,
            'lesson_uid': docRef.id,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veriler başarıyla eklendi.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Koleksiyon zaten dolu.')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $e')),
      );
    }
  }
}