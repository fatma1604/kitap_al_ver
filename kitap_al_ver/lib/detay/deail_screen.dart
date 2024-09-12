import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/configuration/costant/color.dart';
import 'package:kitap_al_ver/detay/addto_cart.dart';
import 'package:kitap_al_ver/detay/detail_app_bar.dart';
import 'package:kitap_al_ver/favori/post.dart';

class DetailScreen extends StatefulWidget {
  final String postUid;

  DetailScreen({
    super.key,
    required this.postUid,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Posts> _postFuture;

  @override
  void initState() {
    super.initState();
    _postFuture = _fetchPost();
  }

  Future<Posts> _fetchPost() async {
    final doc = await FirebaseFirestore.instance
        .collection('post')
        .doc(widget.postUid)
        .get();
    return Posts.fromFirestore(doc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      floatingActionButton: AddToCart(postUid: widget.postUid),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: FutureBuilder<Posts>(
          future: _postFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('No Data Found'));
            }

            final post = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailAppBar(posts: post),
                  // Other widgets to display post details
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
