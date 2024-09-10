/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_card.dart'; // import the file where ProductCard is defined

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  Future<List<String>> getPhotoUrls() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('post').get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final url = data['url'] as String?;
        if (url != null) {
          return url;
        } else {
          throw Exception('URL is null for a document');
        }
      }).toList();
    } else {
      throw Exception('No documents found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getPhotoUrls(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final photoUrls = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final photoUrl = photoUrls[index];
                    return ProductCard(photoUrl: photoUrl);
                  },
                  childCount: photoUrls.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }
}
*/