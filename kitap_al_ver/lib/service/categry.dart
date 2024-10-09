import 'dart:ui';

import 'package:flutter/material.dart';

class CategoryModel {
  final String categoryname;
  final String images;
  final List<String> durum;
  final List<Color> colors;
  final List<String> classes; // Yeni alan
  final List<String> types; // Yeni alan
  final List<String> subjects;
  final List<String> history;
  // Yeni alan

  CategoryModel(
      {required this.categoryname,
      required this.images,
      required this.colors,
      required this.classes,
      required this.types,
      required this.subjects,
      required this.durum,
      required this.history});
}

final List<CategoryModel> kategory = [
  CategoryModel(
      categoryname: 'TYT-KİTAP',
      images: "assets/images/profile.png",
      colors: [
        Colors.deepOrange
      ],
      classes: [
        'Sınıf 9',
        'Sınıf 10'
      ],
      types: [
        'DENEME',
        'SET',
        'TEST'
      ],
      subjects: [
        'BİYOLOJİ',
        'COĞRAFYA',
        'EDEBİYAT',
        'DİLBİLGİSİ',
        'FELSEFE',
        'FİZİK',
        'GEOMETRİ',
        'KİMYA',
        'PARAGRAF',
        'TARİH',
        'TÜRKÇE'
      ],
      durum: [
        'Az Kullanılmış',
        'İkinci El',
        'Yeni'
      ],
      history: [
        "2024",
        "2023",
        "2022",
        "2021",
        "2020",
        "2019",
        "2018"
      ]),
  CategoryModel(
      categoryname: 'AYT-KİTAP',
      images: "assets/images/profile.png",
      colors: [
        Colors.green
      ],
      classes: [
        'Sınıf 11',
        'Sınıf 12'
      ],
      types: [
        'DENEME',
        'SET',
        'TEST'
      ],
      subjects: [
        'BİYOLOJİ',
        'COĞRAFYA',
        'EDEBİYAT',
        'DİLBİLGİSİ',
        'FELSEFE',
        'FİZİK',
        'GEOMETRİ',
        'KİMYA',
        'PARAGRAF',
        'TARİH',
        'TÜRKÇE'
      ],
      durum: [
        'Az Kullanılmış',
        'İkinci El',
        'Yeni'
      ],
      history: [
        "2024",
        "2023",
        "2022",
        "2021",
        "2020",
        "2019",
        "2018"
      ]),
  CategoryModel(
      categoryname: 'LGS-KİTAP',
      images: "assets/images/profile.png",
      colors: [
        Colors.purple
      ],
      classes: [
        'Sınıf 8'
      ],
      types: [
        'DENEME',
        'SET',
        'TEST',
      ],
      subjects: [
        'DİN',
        'TARİH',
        'FEN',
        'KİMYA',
        'İNGİLİZCE',
        'iNKİLAP',
        'TÜRKÇE'
      ],
      durum: [
        'Az Kullanılmış',
        'İkinci El',
        'Yeni'
      ],
      history: [
        "2024",
        "2023",
        "2022",
        "2021",
        "2020",
        "2019",
        "2018"
      ]),
  CategoryModel(
      categoryname: 'KPPS ',
      images: "assets/images/profile.png",
      colors: [
        Colors.purple
      ],
      classes: [
        "ORTA ÖĞRETİM"
        ,"ÖNLİSANAS"
      ],
      types: [
        'DENEME',
        'SET',
        'TEST'
      ],
      subjects: [
        "KPPS GENEL KÜTÜR",
        "KPSS",
        "ALS",
        "YDS",
        "KPSS ÖABT",
        'VATANDAŞLIK',
      ],
      durum: [
        'Az Kullanılmış',
        'İkinci El',
        'Yeni'
      ],
      history: [
        "2024",
        "2023",
        "2022",
        "2021",
        "2020",
        "2019",
        "2018"
      ]),
  CategoryModel(
      categoryname: 'ALES ',
      images: "assets/images/profile.png",
      colors: [
        Colors.purple
      ],
      classes: [
        "ORTA ÖĞRETİM","ÖNLİSANAS"
      ],
      types: [
        'DENEME',
        'SET',
        'TEST'
      ],
      subjects: [
        "als",
        "KPSS",
        "ALS",
        "YDS",
        "KPSS ÖABT",
        'VATANDAŞLIK',
      ],
      durum: [
        'Az Kullanılmış',
        'İkinci El',
        'Yeni'
      ],
      history: [
        "2024",
        "2023",
        "2022",
        "2021",
        "2020",
        "2019",
        "2018"
      ]),
  CategoryModel(
      categoryname: 'TUS  ',
      images: "assets/images/profile.png",
      colors: [
        Colors.purple
      ],
      classes: [
        "ORTA ÖĞRETİM,ÖNLİSANAS"
      ],
      types: [
        'DENEME',
        'SET',
        'TEST'
      ],
      subjects: [
        "TUD",
        "KPSS",
        "ALS",
        "YDS",
        "KPSS ÖABT",
        'VATANDAŞLIK',
      ],
      durum: [
        'Az Kullanılmış',
        'İkinci El',
        'Yeni'
      ],
      history: [
        "2024",
        "2023",
        "2022",
        "2021",
        "2020",
        "2019",
        "2018"
      ]),
  CategoryModel(
      categoryname: 'TUS  ',
      images: "assets/images/profile.png",
      colors: [
        Colors.purple
      ],
      classes: [
        "ORTA ÖĞRETİM","ÖNLİSANAS"
      ],
      types: [
        'DENEME',
        'SET',
        'TEST'
      ],
      subjects: [
        "YDS ",
        "KPSS",
        "ALS",
        "YDS",
        "KPSS ÖABT",
        'VATANDAŞLIK',
      ],
      durum: [
        'Az Kullanılmış',
        'İkinci El',
        'Yeni'
      ],
      history: [
        "2024",
        "2023",
        "2022",
        "2021",
        "2020",
        "2019",
        "2018"
      ]),
];
