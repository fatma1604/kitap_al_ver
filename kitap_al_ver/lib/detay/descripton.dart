import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String postUid; // Belge ID'sini alabilmek için

  Description(
      {super.key, required this.postUid}); // Constructor'da belge ID'si alınır

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 14, 1, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Açıklama",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
            const Text(
              "Özellikler",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_comment_rounded))
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
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            );
          },
        ),
      ],
    );
  }
}
