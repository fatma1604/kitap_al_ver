import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerScreen extends StatefulWidget {
  @override
  _PhotoPickerScreenState createState() => _PhotoPickerScreenState();
}

class _PhotoPickerScreenState extends State<PhotoPickerScreen> {
  File? _image; // Seçilen fotoğrafı tutacak değişken
  String? _downloadUrl; // Fotoğrafın indirme URL'si
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref().child('deneme/$fileName');
      final uploadTask = storageRef.putFile(_image!);

      // Yükleme durumunu dinleme
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Upload progress: ${snapshot.bytesTransferred / snapshot.totalBytes * 100}%');
      });

      final downloadUrl = await (await uploadTask).ref.getDownloadURL();

      setState(() {
        _downloadUrl = downloadUrl;
      });

      print('Upload complete. Download URL: $_downloadUrl');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotoğraf Yükleme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Fotoğraf Seç'),
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.file(
                    _image!,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  )
                : Text('Bir fotoğraf seçilmedi.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Fotoğrafı Yükle'),
            ),
            SizedBox(height: 20),
            _downloadUrl != null
                ? Text('Fotoğraf URL: $_downloadUrl')
                : Container(),
          ],
        ),
      ),
    );
  }
}
