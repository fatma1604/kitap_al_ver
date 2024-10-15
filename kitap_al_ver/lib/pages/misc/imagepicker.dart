import 'dart:io';

import 'package:image_picker/image_picker.dart';


class ImagePickerr {
  Future<File> uploadImage(String source) async {
   
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera);
    return File(image!.path);
  }
}
