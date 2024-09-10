/*import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  String? _selectedClass;
  String? _selectedUsageStatus;
  String? _selectedType;
  String? _selectedSubjec;
  String? _selectedSubject;
  String? postImage;
  List<String> _classes = [];
  List<String> _usageStatuses = [];
  List<String> _types = [];
  List<String> _subjects = [];
  var uid = Uuid().v4();
  String _title = '';
  String _additionalInfo = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool _isCoder = false; // Indicates if the user is a coder

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the screen is initialized
    _checkUserRole();
    // UUID oluştur
  }

 

Future<String?> _uploadProfileImage(File image) async {
  try {
    final storageRef = _storage.ref().child('profile_images/${_auth.currentUser!.uid}.jpg');
    final uploadTask = storageRef.putFile(image);

    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error uploading profile image: $e');
    return null;
  }
}


  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Fetch user information from Firestore
        final userDoc = await _firestore
            .collection('Users')
            .doc(_auth.currentUser!.uid)
            .get();

        if (!userDoc.exists) {
          throw Exception('User document does not exist.');
        }

        // Extract user profile from the document
        final userData = userDoc.data()!;
        final userProfile = userData['profile'] as String?; // Assuming this is a URL or path

        // Validate user profile
        if (userProfile == null) {
          throw Exception('User profile image is missing.');
        }

        // Prepare data to be saved
        final postData = {
          'title': _title.isNotEmpty ? _title : 'Başlık Yok',
          'class': _selectedClass,
          'usageStatus': _selectedUsageStatus,
          'type': _selectedType,
          'subject': _selectedSubjec,
          'additionalInfo': _additionalInfo.isNotEmpty ? _additionalInfo : 'Ek Bilgi Yok',
          'createdAt': FieldValue.serverTimestamp(),
          'user_uid': _auth.currentUser!.uid,
          'post_uid': uid, // UUID
          'postImage': postImage ?? '', // Handle null cases
          'profileImage': userProfile, // Use the profile from Firestore
        };

        // Save data to Firestore
        await FirebaseFirestore.instance.collection('post').doc(uid).set(postData);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bilgiler başarıyla kaydedildi!')),
        );

        // Navigate to the next screen
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mykonum()));
      } catch (e) {
        // Print detailed error for debugging
        print('Error saving information: $e');

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bilgileri kaydederken bir hata oluştu: $e')),
        );
      }
    }
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
        postImage = result.isNotEmpty ? result.first : null;
      });
    }
  }

  Future<void> _checkUserRole() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('Users').doc(user.uid).get();
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
    return Scaffold(
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

  // You can keep the _class, _case, _type, and _lesson methods as they are, if you need them.
}
*/