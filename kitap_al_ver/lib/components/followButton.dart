import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitap_al_ver/models/usermodel.dart';
import 'package:kitap_al_ver/pages/chat/chat_page.dart';
import 'package:kitap_al_ver/utils/color.dart';

class FollowButton extends StatelessWidget {
  final String userId;
  final bool follow;
  final VoidCallback onFollowToggle;
  final Usermodel user;

  const FollowButton({
    required this.follow,
    required this.onFollowToggle,
    required this.user,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onFollowToggle,
              child: Container(
                alignment: Alignment.center,
                height: 30.h,
                decoration: BoxDecoration(
                  color: follow ? Colors.grey.shade200 : AppColor.userTitle,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: follow ? Colors.grey.shade200 : AppColor.userTitle),
                ),
                child: Text(
                  follow ? 'Unfollow' : 'Follow',
                  style: TextStyle(color: follow ? Colors.black : Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiverEmail: user.email,
                      receiverId: userId,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Text('Message', style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
