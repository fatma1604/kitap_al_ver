// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:kitap_al_ver/model/product_model.dart';
import 'package:kitap_al_ver/screnn/widget/imageCarousel.dart';
import 'package:kitap_al_ver/widget/product_Card.dart';


//1
class Books_Home extends StatefulWidget {
  const Books_Home({super.key});

  @override
  State<Books_Home> createState() => _Books_Home();
}

class _Books_Home extends State<Books_Home> {
  int currentSlider = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<List<Product>> selectcategories = [
      all,
      shoes,
      beauty,
      womenFashion,
      jewelry,
      menFashion
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImageCarousel(),
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ProductCard(
                product: selectcategories[selectedIndex][index],
              );
            },
            childCount: selectcategories[selectedIndex].length,
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
  }
}
