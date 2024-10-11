import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/components/comment.dart';
import 'package:kitap_al_ver/pages/widget/theme/text.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/utils/color.dart';
import 'package:kitap_al_ver/utils/images.dart';


class Description extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String postUid; 

  Description({super.key, required this.postUid});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(child: Text(AppText.generalError)); // Updated message
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
              child: Text(
                AppText.description, // Use AppText for description
                style: AppTextTheme.description(context),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              AppText.features, // Use AppText for features
              style: AppTextTheme.description(context),
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
                            username: currentUser.displayName ?? AppText.defaultUsername,
                            profilePhotoUrl: currentUser.photoURL ?? AppText.defaultProfilePhotoUrl,
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Image.asset(
            AppImage.comment,
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
              return const Center(child: Text(AppText.generalError)); // Updated error message
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text(AppText.noDescriptionFound)); // Use AppText for no description
            }

            final description = snapshot.data!.get('additionalInfo') ?? AppText.noDescriptionAvailable;
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
