import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  final String bookTitle;

  const PostsScreen({Key? key, required this.bookTitle}) : super(key: key);

  // Fetch posts based on the selected category (bookTitle)
  Future<List<Map<String, dynamic>>> getPosts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('post')
        .where('category', isEqualTo: bookTitle) // Filter by category
        .get();

    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookTitle),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/book.jpeg', // Adjust the path as necessary
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text('No posts available for this category.'),
                ],
              ),
            );
          }

          final photoDataList = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: photoDataList.length,
            itemBuilder: (context, index) {
              
              return Card(
               
              );
            },
          );
        },
      ),
    );
  }
}
