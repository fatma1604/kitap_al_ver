import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kitap_al_ver/aramabut/image_cached.dart';

import 'package:kitap_al_ver/aramabut/searchisyory.dart';
import 'package:kitap_al_ver/tabbar/profil_screen.dart';
// Import the search history helper

class Explone extends StatefulWidget {
  const Explone({Key? key}) : super(key: key);

  @override
  _ExploneState createState() => _ExploneState();
}

class _ExploneState extends State<Explone> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool _showGrid = true;
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final history = await SearchHistory.getHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  void _updateSearchHistory(String searchTerm) {
    SearchHistory.addToHistory(searchTerm);
    _loadSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildSearchBox(),
            if (_showGrid)
              StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore.collection('posts').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  final documents = snapshot.data!.docs;
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final snap = documents[index];
                      },
                      childCount: documents.length,
                    ),
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 3,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      pattern: const [
                        QuiltedGridTile(2, 1),
                        QuiltedGridTile(2, 2),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                      ],
                    ),
                  );
                },
              ),
            if (!_showGrid)
              StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore
                    .collection('Users')
                    .where('username',
                        isGreaterThanOrEqualTo: _searchController.text)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  final documents = snapshot.data!.docs;
                  return SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final snap = documents[index];
                          return Column(
                            children: [
                              SizedBox(height: 10.h),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ProfilScreen(userId: snap.id),
                                  ));
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 23.r,
                                      backgroundImage:
                                          NetworkImage(snap['profile']),
                                    ),
                                    SizedBox(width: 15.w),
                                    Text(snap['username']),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        childCount: documents.length,
                      ),
                    ),
                  );
                },
              ),
            if (_searchHistory.isNotEmpty && _showGrid)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Searches',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      ..._searchHistory.map((term) => ListTile(
                            title: Text(term),
                            onTap: () {
                              _searchController.text = term;
                              setState(() {
                                _showGrid = false;
                              });
                            },
                          )),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBox() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Container(
          width: double.infinity, // Make sure it takes full width
          height: 45.h,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 243, 157, 157),
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_rounded, color: Colors.black),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _showGrid = value.isEmpty;
                      });
                      if (value.isNotEmpty) {
                        _updateSearchHistory(value);
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search User',
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
