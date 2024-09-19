// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/misc/MyImage_slider.dart';
import 'package:kitap_al_ver/components/descripton.dart';
import 'package:kitap_al_ver/components/detail_app_bar.dart';
import 'package:kitap_al_ver/models/post.dart';
import 'package:kitap_al_ver/pages/product/addto_cart.dart';
import 'package:kitap_al_ver/pages/product/items_detalis.dart'; // Assuming this is a widget


class DetailScreen extends StatefulWidget {
  final String postUid;
  final String photoUrl;
  

  DetailScreen({super.key, required this.postUid, required this.photoUrl});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentImage = 0;
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
    //  backgroundColor: kcontentColor,
      floatingActionButton: AddToCart(postUid: widget.postUid,photoUrl:widget.photoUrl ,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: FutureBuilder<Posts>(
          future: _postFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No Data Found'));
            }

            final post = snapshot.data!;
            final images = post.imageUrls;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailAppBar(posts: post),
                  MyImageSlider(
                    imageUrls: images,
                    onChange: (index) {
                      setState(() {
                        currentImage = index;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: currentImage == index ? 15 : 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentImage == index
                              ? Colors.black
                              : Colors.transparent,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemsDetails(
                          post: post,
                        ), // Assuming this is a widget that displays item details
                        const SizedBox(height: 20),

                        const SizedBox(height: 20),
                        Description(
                          postUid: widget.postUid,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
