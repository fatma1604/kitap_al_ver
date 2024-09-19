// ignore_for_file: unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';

class CategoryModel {
  final String categoryname;
  final String images;
final List<Color> colors;

  CategoryModel(  {
    required this.categoryname,
    required this.images,
    required this.colors,
  });
}
 
final List<CategoryModel> kategory = [
CategoryModel(categoryname: 'TYT-KİTAP',images: "assets/images/profile.png", colors:[Colors.deepOrange,] ),
CategoryModel(categoryname: 'AYT-KİTAP',images: "assets/images/profile.png",colors:[ Colors.green],),
CategoryModel(categoryname:'LGS-KİTAP',images: 'assets/images/profile.png',colors:[ Colors.purple,],),
CategoryModel(categoryname: 'KPPS-KİTAP',images: "assets/images/profile.png", colors:[ Colors.brown,] ),
CategoryModel(categoryname: 'ALES-KİTAP',images: "assets/images/profile.png",colors:[ Colors.indigo,],),
CategoryModel(categoryname: 'TUS-KİTAP',images: 'assets/images/profile.png',colors:[ Colors.teal,],),
  CategoryModel(categoryname: 'YDS',images: 'assets/images/profile.png',colors:[ Colors.blue,],),
  CategoryModel(categoryname: 'Okuma Kitabı',images: 'assets/images/profile.png',colors:[ Colors.pink,],),
];
