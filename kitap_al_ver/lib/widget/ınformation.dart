
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/mykonum.dart';
import 'package:uuid/uuid.dart';

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
  String _title = '';
  String _additionalInfo = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _uniqueId;  // UUID'yi tutmak için bir değişken

  @override
  void initState() {
    super.initState();
    // UUID oluştur
    var uuid = Uuid();
    _uniqueId = uuid.v4();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Firestore'da bir belge oluştur ve verileri kaydet
        await FirebaseFirestore.instance.collection('ilanlar').doc(_uniqueId).set({
          'title': _title.isNotEmpty ? _title : 'Başlık Yok',
          'class': _selectedClass,
          'usageStatus': _selectedUsageStatus,
          'type': _selectedType,
          'subject': _selectedSubject,
          'additionalInfo': _additionalInfo.isNotEmpty ? _additionalInfo : 'Ek Bilgi Yok',
          'createdAt': FieldValue.serverTimestamp(),
          'uid': _uniqueId,
          'user_uid':_auth.currentUser!.uid,
        });

        // Başarılı olduğunda bir mesaj göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bilgiler başarıyla kaydedildi!')),
        );

        // Bir sonraki ekrana git
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>  Mykonum ()));
      } catch (e) {
        print('Error saving information: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bilgileri kaydederken bir hata oluştu!')),
        );
      }
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
                onChanged: (value) {
                  _title = value;
                },
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Sınıf Seçimi',
                  border: OutlineInputBorder(),
                ),
                value: _selectedClass,
                items: ['Sınıf 9', 'Sınıf 10'].map((classItem) {
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
                  _additionalInfo = value;
                },
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Devam Et'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
