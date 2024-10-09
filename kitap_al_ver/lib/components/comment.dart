import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitap_al_ver/pages/misc/image_cached.dart';
import 'package:kitap_al_ver/pages/widget/theme/text_them.dart';
import 'package:kitap_al_ver/utils/color.dart';


class Comment extends StatefulWidget {
  final String type;
  final String uid;
  final String username;
  final String profilePhotoUrl;

  const Comment({
    Key? key,
    required this.type,
    required this.uid,
    required this.username,
    required this.profilePhotoUrl,
  }) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final TextEditingController _commentController = TextEditingController();

  Future<void> _sendComment() async {
    String comment = _commentController.text.trim();
    if (comment.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection(widget.type)
            .doc(widget.uid)
            .collection('comments')
            .add({
          'comment': comment,
          'username': widget.username,
          'profileImage': widget.profilePhotoUrl,
          'timestamp': FieldValue.serverTimestamp(),
        });

        _commentController.clear();
      } catch (e) {
        print('Error sending comment: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Could not send comment. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You cannot send an empty comment.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.r),
        topRight: Radius.circular(25.r),
      ),
      child: Container(
        color: isDarkMode ? AppColor.onbordingdark : AppColor.onbordinglight,
        height: 400.h,
        child: Stack(
          children: [
            Positioned(
              top: 8.h,
              left: 140.w,
              child: Container(
                width: 100.w,
                height: 3.h,
                color: Colors.black,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(widget.type)
                        .doc(widget.uid)
                        .collection('comments')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No comments yet.'));
                      }

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return commentItem(snapshot.data!.docs[index].data());
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    },
                  ),
                ),
                Container(
                  height: 60.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 45.h,
                        width: 200.w,
                        child: TextField(
                          controller: _commentController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Add a comment',
                            border: InputBorder.none,
                            hintStyle: AppTextTheme.comment(context), // Güncellendi
                          ),
                          onTap: () {
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: AppColor.white),
                        onPressed: _sendComment,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget commentItem(final snapshot) {
    return ListTile(
      leading: ClipOval(
        child: SizedBox(
          height: 35.h,
          width: 35.w,
          child: CachedImage(snapshot['profileImage']),
        ),
      ),
      title: Text(
        snapshot['username'],
        style: AppTextTheme.comment(context), // Stil güncellendi
      ),
      subtitle: Text(
        snapshot['comment'],
        style: AppTextTheme.comment(context), // Stil güncellendi
      ),
    );
  }
}
