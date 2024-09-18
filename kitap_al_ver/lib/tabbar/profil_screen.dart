// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/aramabut/image_cached.dart';
import 'package:kitap_al_ver/model/usermodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kitap_al_ver/pages/data/firebes_post.dart';

class ProfilScreen extends StatefulWidget {
  final String userId;

  ProfilScreen({required this.userId});

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<Usermodel> userModelFuture;
  int post_length = 0;
  List following = [];
  bool follow = false;
  bool yourse = false; // Profilin senin olup olmadığını belirten bir boolean

  @override
  void initState() {
    super.initState();
    userModelFuture = fetchUserData(widget.userId);
    getdata(); // Ensure data is fetched when initializing
  }

  Future<Usermodel> fetchUserData(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    return Usermodel.fromFirestore(snapshot);
  }

  getdata() async {
    DocumentSnapshot snap = await _firebaseFirestore
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get();
    following = (snap.data()! as dynamic)['following'];
    if (following.contains(widget.userId)) {
      setState(() {
        follow = true;
      });
    }
  }

  Widget Head(Usermodel user) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                child: ClipOval(
                  child: SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: CachedImage(user.profile),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 35.w),
                      Text(
                        post_length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 53.w),
                      Text(
                        user.followers.length.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.white),
                      ),
                      SizedBox(width: 70.w),
                      Text(
                        user.following.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30.w),
                      Text(
                        'Posts',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(width: 19.w),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  user.bio,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Visibility(
            visible: !follow,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: GestureDetector(
                onTap: () {
                  if (!yourse) {
                    FirebasePostServis().flollow(uid: widget.userId);
                    setState(() {
                      follow = true;
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: yourse ? Colors.white : Colors.blue,
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(
                        color: yourse ? Colors.grey.shade400 : Colors.blue),
                  ),
                  child: yourse
                      ? Text('Edit Your Profile')
                      : Text(
                          'Follow',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: follow,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FirebasePostServis().flollow(uid: widget.userId);
                        setState(() {
                          follow = false;
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 30.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Text('Unfollow')),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        'Message',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usermodel>(
      future: userModelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          Usermodel user = snapshot.data!;
          return DefaultTabController(
            length: 3, // Number of tabs
            child: Scaffold(
              appBar: AppBar(
                title: Text(user.username),
              ),
              body: Column(
                children: [
                  Head(user),
                  SizedBox(
                      height: 10.h), // Add spacing between head and tab bar
                  TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on)),
                      Tab(icon: Icon(Icons.video_collection)),
                      Tab(icon: Icon(Icons.person)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(child: Text("Posts")),
                        Center(child: Text("Videos")),
                        Center(child: Text("Profile")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: Text('User not found'));
        }
      },
    );
  }
}
