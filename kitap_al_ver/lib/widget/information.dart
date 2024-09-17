// ignore_for_file: unused_field, file_names, use_key_in_widget_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/pages/data/for%C4%B1mHelper.dart';
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
  List<String>? _postImages;
  List<String> _classes = [];
  List<String> _usageStatuses = [];
  List<String> _types = [];
  List<String> _subjects = [];
  List<String> _like = [];
  var uid = const Uuid().v4();
  String _title = '';
  String _description = '';
  String _additionalInfo = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isCoder = false;

  @override
  void initState() {
    super.initState();
    FormHelpers.fetchData(
      firestore: _firestore,
      onClassesFetched: (classes) => setState(() => _classes = classes),
      onUsageStatusesFetched: (statuses) => setState(() => _usageStatuses = statuses),
      onTypesFetched: (types) => setState(() => _types = types),
      onSubjectsFetched: (subjects) => setState(() => _subjects = subjects),
    );
    FormHelpers.checkUserRole(
      _auth,
      _firestore,
      (isCoder) => setState(() => _isCoder = isCoder),
    );
  }

  Future<void> navigateToGallery() async {
    FormHelpers.navigateToGallery(context, (images) {
      setState(() {
        _postImages = images;
      });
    });
  }

  Future<void> submitForm() async {
    FormHelpers.submitForm(
      context: context,
      formKey: _formKey,
      title: _title,
      selectedClass: _selectedClass,
      selectedUsageStatus: _selectedUsageStatus,
      selectedType: _selectedType,
    selectedSubject: _selectedSubjec,
      additionalInfo: _additionalInfo,
      description: _description,
      postImages: _postImages,
      like: _like,
      auth: _auth,
      firestore: _firestore,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Bilgi Ekleme',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: navigateToGallery,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                onPressed: submitForm,
                child: const Text('Devam Et'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
