// ignore_for_file: unnecessary_brace_in_string_interps, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/utils/color.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

 
  String? get _currentUserId => _auth.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? AppColor.screendart
          : AppColor.screenlight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColor.screendart
            : AppColor.screenlight,
        title: const Text(
          "Sepet",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('sepet')
            .where('userId', isEqualTo: _currentUserId)
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
              final postId = item['postuid']; 

              return FutureBuilder<DocumentSnapshot>(
                future: _firestore.collection('post').doc(postId).get(),
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!postSnapshot.hasData || !postSnapshot.data!.exists) {
                    return const Center(child: Text(""));
                  }

                  final post = postSnapshot.data!;
                  final List<dynamic> postImages =
                      post['postImages']; 
                  final String photoUrl = postImages.isNotEmpty
                      ? postImages[0]
                      : ''; 
                  final String title =
                      post['title']; 
                  final String addition =
                      post['additionalInfo'];

                  return Dismissible(
                    key: Key(item.id), 
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) async {
                      
                      await _firestore
                          .collection('sepet')
                          .doc(item.id)
                          .delete();

                     
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("$title sepetten silindi.")),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor.buttonlight,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                photoUrl.isNotEmpty
                                    ? photoUrl
                                    : 'default_image_url.png', 
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
                                
                                  Text("Ürün açıklaması",
                                      style: AppTextTheme.emphasized(context)),
                                  const SizedBox(height: 5),
                                 
                                  Text(title,
                                      style: AppTextTheme.body(context)),
                                  const SizedBox(height: 5),
                               
                                  Text(addition,
                                      style: AppTextTheme.body(context)),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: AppColor.fromdart),
                              onPressed: () async {
                               
                                await _firestore
                                    .collection('sepet')
                                    .doc(item.id)
                                    .delete();

                            
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("$title sepetten silindi.")),
                                );
                              },
                            ),
                          ],
                        ),
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
