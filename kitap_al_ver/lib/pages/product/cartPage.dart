// ignore_for_file: unnecessary_brace_in_string_interps, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sepet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('sepet')
            .where('userId', isEqualTo: _currentUserId) // Filter by current user
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.docs;

          if (cartItems.isEmpty) {
            return const Center(child: Text("Sepetinizde ürün yok."));
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              final postId = item['postuid']; // Get post ID to fetch details

              return FutureBuilder<DocumentSnapshot>(
                future: _firestore.collection('post').doc(postId).get(),
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!postSnapshot.hasData || !postSnapshot.data!.exists) {
                    return const Center(child: Text("Ürün bulunamadı."));
                  }

                  final post = postSnapshot.data!;
                  final List<dynamic> postImages = post['postImages']; // Ensure this field exists
                  final String photoUrl = postImages.isNotEmpty ? postImages[0] : ''; // Use first image
                  final String title = post['title']; // Ensure this field exists
                  final String price = post['usageStatus']; // Ensure this field exists and represents price

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              photoUrl.isNotEmpty ? photoUrl : 'default_image_url.png', // Handle empty image URL
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$${price}", // Display price correctly
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
