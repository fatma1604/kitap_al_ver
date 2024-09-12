import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kitap_al_ver/favori/post.dart';
// Ensure Detay is imported

class ItemsDetails extends StatelessWidget {
  final Posts post;

  const ItemsDetails({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                // For rating
                Row(
                  children: [
                    Container(
                      width: 65,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 156, 82, 82),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 15,
                            color: Color.fromARGB(255, 224, 95, 95),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            post.rating, // Display rating with one decimal
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "User: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                    text:post.userName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Future<String> fetchUserName(String? userId) async {
    if (userId == null) return 'user'; // Default if no userId is available
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      final userData = userDoc.data() as Map<String, dynamic>;
      return userData['username'] ?? 'user'; // Default if userName is null
    } catch (e) {
      print('Error fetching user: $e');
      return 'user'; // Default in case of error
    }
  }
}
