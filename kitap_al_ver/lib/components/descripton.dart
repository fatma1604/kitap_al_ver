import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication'ı ekleyin
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/comment.dart';
import 'package:kitap_al_ver/utils/color.dart';

class Description extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String postUid; // Belge ID'sini alabilmek için

  Description(
      {super.key, required this.postUid}); // Constructor'da belge ID'si alınır

  @override
  Widget build(BuildContext context) {
    // Mevcut kullanıcıyı al
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Kullanıcı mevcut değilse bir mesaj göster
    if (currentUser == null) {
      return Center(child: Text('Kullanıcı giriş yapmadı.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 130,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.buttonlight,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Açıklama",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 16),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Özellikler",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 16),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                showBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: DraggableScrollableSheet(
                        maxChildSize: 0.6,
                        initialChildSize: 0.6,
                        minChildSize: 0.2,
                        builder: (context, scrollController) {
                          return Comment(
                            type: 'post', 
                            uid: postUid, 
                            username: currentUser.displayName ??
                                'Kullanıcı Adı', 
                            profilePhotoUrl: currentUser.photoURL ??
                                'Profil Resmi URL', 
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Image.asset(
                'assets/images/comment.webp',
                height: 28,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 20),
        StreamBuilder<DocumentSnapshot>(
          stream: _firestore.collection('post').doc(postUid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('No description found!'));
            }

            final description = snapshot.data!.get('additionalInfo') ??
                'No description available';
            return Text(
              description,
              style: const TextStyle(fontSize: 16, color: AppColor.black),
            );
          },
        ),
      ],
    );
  }
}
