import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/configuration/core/custom_icon_button.dart';
import 'package:kitap_al_ver/post/add_post_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class Galleripage extends StatefulWidget {
  const Galleripage({super.key});

  @override
  State<Galleripage> createState() => _GalleripageState();
}

class _GalleripageState extends State<Galleripage> {
    final List<Widget> _mediaList = [];
  final List<File> _path = [];
  File? _selectedFile;
  int _currentPage = 0;
  int? _lastPage;
  Future<void> _fetchNewMedia() async {
    _lastPage = _currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(page: _currentPage, size: 60);

      List<Widget> tempMediaList = [];
      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            _path.add(File(file.path));
            _selectedFile = _path[0]; // Update the selected file
          }
          tempMediaList.add(
            FutureBuilder(
              future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(); // Placeholder while loading
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

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  void _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= .33) return;
    if (_currentPage == _lastPage) return;
    _fetchNewMedia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        leading: CustomIconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icons.arrow_back,
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () {
                  if (_selectedFile != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddPostTextScreen(_selectedFile!),
                    ));
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 15.sp, color: Colors.blue),
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
                    itemCount: _mediaList.isEmpty ? 1 : _mediaList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      return _mediaList[index];
                    },
                  ),
                ),
                SizedBox(height: 10.h), // Adding some spacing
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling for inner GridView
                  itemCount: _mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFile = _path[index];
                        });
                      },
                      child: _mediaList[index],
                    );
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
