// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitap_al_ver/configuration/core/custom_icon_button.dart';
import 'package:kitap_al_ver/configuration/core/short_h_bar.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:kitap_al_ver/configuration/costant/show_alert_dialog.dart';
import 'package:kitap_al_ver/pages/widget/loginorregister/image_picker_page.dart';


class UserInfoPage extends StatefulWidget {
  final String? profileImageUrl;
  final String? backgroundImageUrl;
  const UserInfoPage(
      {super.key, this.profileImageUrl, this.backgroundImageUrl});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  File? imageCamera;
  Uint8List? imageGallery;

  late TextEditingController usernameController;
  

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShortHBar(),
            Row(
              children: [
                const SizedBox(width: 20),
                const Text(
                  'Profile photo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                CustomIconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.close,
                ),
                const SizedBox(width: 15),
              ],
            ),
            Divider(
              color: Colors.amber
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 20),
                imagePickerIcon(
                  onTap: pickmageFromCamera,
                  icon: Icons.camera_alt_rounded,
                  text: 'Camera',
                ),
                const SizedBox(width: 15),
                imagePickerIcon(
                  onTap: () async {
                    Navigator.pop(context);
                    final image = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImagePickerPage(),
                      ),
                    );
                    if (image == null) return;
                    setState(() {
                      imageGallery = image;
                      imageCamera = null;
                    });
                  },
                  icon: Icons.photo_camera_back_rounded,
                  text: 'Gallery',
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  pickmageFromCamera() async {
    try {
      Navigator.pop(context);
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageCamera = File(image!.path);
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onPressed: onTap,
          icon: icon,
          iconColor: AppColor.greenDark,
          minWidth: 50,
          border: Border.all(
            color: const Color.fromARGB(255, 36, 16, 10),
            width: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: imagePickerTypeBottomSheet,
            child: Transform.translate(
              offset: const Offset(0, -10),
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null
                        ? Colors.transparent
                        : Colors.black,
                    width: 2,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageGallery != null
                        ? MemoryImage(imageGallery!)
                        : widget.profileImageUrl != null
                            ? NetworkImage(widget.profileImageUrl!)
                            : imageCamera != null
                                ? FileImage(imageCamera!) as ImageProvider
                                : AssetImage('assets/images/indir.png'),
                  ),
                ),

                height: 90.w, // Adjust size as needed
                width: 90.w, // Adjust size as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
