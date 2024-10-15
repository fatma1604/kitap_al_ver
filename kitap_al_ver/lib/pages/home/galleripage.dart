// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kitap_al_ver/components/custom_icon_button.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/utils/color.dart';

import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

class Galleripage extends StatefulWidget {
  final File? initialImage;

  const Galleripage({super.key, this.initialImage});

  @override
  State<Galleripage> createState() => _GalleripageState();
}

class _GalleripageState extends State<Galleripage> {
  final List<Widget> _mediaList = [];
  final List<File> _path = [];
  final Set<File> _selectedFiles = {};
  int _currentPage = 0;
  int? _lastPage;

  @override
  void initState() {
    super.initState();
    if (widget.initialImage != null) {
      _selectedFiles.add(widget.initialImage!);
    }
    _fetchNewMedia();
  }

  Future<void> _fetchNewMedia() async {
    _lastPage = _currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      if (albums.isEmpty) return;

      List<AssetEntity> media =
          await albums[0].getAssetListPaged(page: _currentPage, size: 60);

      if (media.isEmpty) return;

      List<Widget> tempMediaList = [];
      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            _path.add(file);
          }
          tempMediaList.add(
            FutureBuilder(
              future:
                  asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedFiles.contains(file)) {
                          _selectedFiles.remove(file);
                        } else if (_selectedFiles.length < 3) {
                          _selectedFiles.add(file!);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (_selectedFiles.contains(file))
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          );
        }
      }
      setState(() {
        _mediaList.addAll(tempMediaList);
        _currentPage++;
      });
    } else {
      PhotoManager.openSetting();
    }
  }

  void _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= .33) return;
    if (_currentPage == _lastPage) return;
    _fetchNewMedia();
  }

  Future<void> _uploadImagesAndNavigate() async {
    try {
      final storage = FirebaseStorage.instance;
      final auth = FirebaseAuth.instance;
      final uid = const Uuid().v4();
      List<String> downloadUrls = [];

      for (File file in _selectedFiles) {
        final fileName = file.uri.pathSegments.last;
        final ref = storage
            .ref()
            .child('post')
            .child(auth.currentUser!.uid)
            .child(uid)
            .child(fileName);

        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot snapshot = await uploadTask;

        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }

      if (downloadUrls.isNotEmpty) {
        Navigator.pop(context, downloadUrls);
      } else {
        Fluttertoast.showToast(
          msg: "No images selected.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error uploading images.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      print("Error uploading images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? AppColor.screendart : AppColor.screenlight,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: isDarkMode
            ? AppColor.screendart
            : AppColor.screenlight, // Specify background color here
        leading: CustomIconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icons.arrow_back,
        ),
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(color: AppColor.black),
        ),
        centerTitle: false,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () {
                  if (_selectedFiles.isNotEmpty) {
                    _uploadImagesAndNavigate();
                  }
                },
                child: Text(
                  'Next',
                  style: AppTextTheme.emphasized(context),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scroll) {
            _handleScrollEvent(scroll);
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 375.h,
                  child: GridView.builder(
                    itemCount: _selectedFiles.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      final file = _selectedFiles.elementAt(index);
                      return Image.file(
                        file,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return _mediaList.isNotEmpty
                        ? _mediaList[index]
                        : Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
