import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/pages/misc/image_cached.dart';
import 'package:kitap_al_ver/pages/profile/post_screen.dart';
import 'package:kitap_al_ver/service/firebes_post.dart';
import 'package:kitap_al_ver/utils/aprouta.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:kitap_al_ver/models/usermodel.dart';

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
  int postLength = 0;
  List following = [];
  bool follow = false;
  bool yourse = false;

  @override
  void initState() {
    super.initState();
    userModelFuture = fetchUserData(widget.userId);
    getData();
  }

  Future<Usermodel> fetchUserData(String userId) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('Users').doc(userId).get();
    return Usermodel.fromFirestore(snapshot);
  }

  getData() async {
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

  Widget head(Usermodel user) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColor.screendart
          : AppColor.screenlight,
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
                        postLength.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.white),
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
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30.w),
                      Text(
                        'Posts',
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                      SizedBox(width: 25.w),
                      Text(
                        'Followers',
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                      SizedBox(width: 19.w),
                      Text(
                        'Following',
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
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
                      color: Colors.white),
                ),
                SizedBox(height: 5.h),
                Text(
                  user.bio,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
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
                    color: yourse ? Colors.white : AppColor.userTitle,
                    borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(
                        color:
                            yourse ? Colors.grey.shade400 : AppColor.userTitle),
                  ),
                  child: yourse
                      ? const Text('Edit Your Profile')
                      : const Text(
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
                          child: const Text(
                            'Unfollow',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.chat,
                        );
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
                        child: const Text(
                          'Message',
                          style: TextStyle(color: Colors.black),
                        ),
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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          Usermodel user = snapshot.data!;

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColor.screendart
                  : AppColor.screenlight,
              appBar: AppBar(
                title: Text(user.username),
              ),
              body: Column(
                children: [
                  head(user),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firebaseFirestore
                          .collection('post')
                          .where('user_uid', isEqualTo: widget.userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        postLength = snapshot.data!.docs.length;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: postLength,
                          itemBuilder: (context, index) {
                            final snap = snapshot.data!.docs[index];
                            final postUid = snap.id;
                            final photoUrl = (snap['postImages'] is List)
                                ? snap['postImages'][0]
                                : snap['postImages'];

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PostScreen(
                                    postUid: postUid,
                                    photoUrl: photoUrl,
                                  ),
                                ));
                              },
                              child: CachedImage(photoUrl),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('User not found'));
        }
      },
    );
  }
}
