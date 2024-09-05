// ignore_for_file: unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';

class Kategorymodel {
  final String categoryname;
  final String images;
final List<Color> colors;

  Kategorymodel(  {
    required this.categoryname,
    required this.images,
    required this.colors,
  });
}
 
final List<Kategorymodel> kategory = [
  Kategorymodel(categoryname: 'TYT-KİTAP',images: "assets/images/profile.png", colors:[Colors.deepOrange,] ),
  Kategorymodel(categoryname: 'AYT-KİTAP',images: "assets/images/profile.png",colors:[ Colors.green],),
  Kategorymodel(categoryname:'LGS-KİTAP',images: 'assets/images/profile.png',colors:[ Colors.purple,],),
  Kategorymodel(categoryname: 'KPPS-KİTAP',images: "assets/images/profile.png", colors:[ Colors.brown,] ),
  Kategorymodel(categoryname: 'ALES-KİTAP',images: "assets/images/profile.png",colors:[ Colors.indigo,],),
  Kategorymodel(categoryname: 'TUS-KİTAP',images: 'assets/images/profile.png',colors:[ Colors.teal,],),
    Kategorymodel(categoryname: 'YDS',images: 'assets/images/profile.png',colors:[ Colors.blue,],),
    Kategorymodel(categoryname: 'Okuma Kitabı',images: 'assets/images/profile.png',colors:[ Colors.pink,],),
];
