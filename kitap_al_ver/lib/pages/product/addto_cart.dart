// ignore_for_file: use_super_parameters, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:uuid/uuid.dart';

class AddToCart extends StatefulWidget {
  final String postUid;
  final String photoUrl;

  const AddToCart({Key? key, required this.postUid, required this.photoUrl})
      : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var uid = const Uuid().v4();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> _getUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return 'Unknown User';
  }

  Future<void> _addToCart() async {
    try {
      final userId = await _getUserId();
      final postUid = widget.postUid;
      final photoUrl = widget.photoUrl;

      await _firestore.collection('sepet').doc(uid).set({
        'postuid': postUid,
        'userId': userId,
        "cartud": uid,
        // Unique cart ID
        'photoUrl': photoUrl,
      });

      const snackBar = SnackBar(
        backgroundColor: AppColor.darttBg,
        content: Text(
          "Successfully added!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: AppColor.white,
          ),
        ),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.transparent, width: 2),
              ),
            ),
            GestureDetector(
              onTap: _addToCart,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 63, 38, 38),
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  "Sepete Ekle",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
