// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SimpleCameraTest extends StatefulWidget {
  @override
  _SimpleCameraTestState createState() => _SimpleCameraTestState();
}

class _SimpleCameraTestState extends State<SimpleCameraTest> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Capture Image'),
            ),
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }
}