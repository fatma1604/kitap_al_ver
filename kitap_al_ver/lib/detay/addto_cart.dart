import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddToCart extends StatefulWidget {
  final String postUid; // Ürün ID'si bu widget'a dışarıdan geçirilecek.

  const AddToCart({Key? key, required this.postUid}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addToCart() async {
    try {
     
      
      // Dinamik ürün ID'sini kullan
      final postUid = widget.postUid;
      
      // Firestore'da koleksiyon ve belge yapısını belirleyin
      await _firestore.collection('cart').add({
        'productId': postUid,
        'quantity': 1, // Örnek olarak 1 adet ekliyoruz
        'timestamp': Timestamp.now(),
        // Burada diğer gerekli bilgileri ekleyebilirsiniz
      });
      
      // Başarıyla eklendiğinde SnackBar göster
      const snackBar = SnackBar(
        content: Text(
          "Successfully added!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      // Hata durumu için bir mesaj göster
      print("Error adding to cart: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.transparent, width: 2),
              ),
            ),
            GestureDetector(
              onTap: _addToCart,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 63, 38, 38),
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
