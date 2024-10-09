import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  final String bookTitle;

  const PostsScreen({Key? key, required this.bookTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookTitle),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('post')
            .where('category', isEqualTo: bookTitle) // Filter by category
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No posts available.'));
          }

          final posts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(post['title'] ?? 'No Title'),
                subtitle: Text(post['description'] ?? 'No Description'),
              );
            },
          );
        },
      ),
    );
  }
}
