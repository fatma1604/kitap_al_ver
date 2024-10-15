// ignore_for_file: unnecessary_import



class CategoryModel {
  final String categoryname;
  final String images;
  final List<String> durum;
 
  final List<String> classes; 
  final List<String> types;
  final List<String> subjects;
  final List<String> history;

  CategoryModel({
    required this.categoryname,
    required this.images,
  
    required this.classes,
    required this.types,
    required this.subjects,
    required this.durum,
    required this.history,
  });
}


final List<CategoryModel> kategory = [
  CategoryModel(
    categoryname: 'TYT-KİTAP',
    images: "assets/images/1.png",
  
    classes: ['Sınıf 9', 'Sınıf 10'],
    types: ['DENEME', 'SET', 'TEST'],
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
    durum: ['Az Kullanılmış', 'İkinci El', 'Yeni'],
    history: ["2024", "2023", "2022", "2021", "2020", "2019", "2018"],
  ),
  CategoryModel(
    categoryname: 'AYT-KİTAP',
    images: "assets/images/1.png",
   
    classes: ['Sınıf 11', 'Sınıf 12'],
    types: ['DENEME', 'SET', 'TEST'],
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
    durum: ['Az Kullanılmış', 'İkinci El', 'Yeni'],
    history: ["2024", "2023", "2022", "2021", "2020", "2019", "2018"],
  ),
  CategoryModel(
    categoryname: 'LGS-KİTAP',
    images: "assets/images/1.png",

    classes: ['Sınıf 8'],
    types: ['DENEME', 'SET', 'TEST'],
    subjects: [
      'DİN',
      'TARİH',
      'FEN',
      'KİMYA',
      'İNGİLİZCE',
      'İNKILAP',
      'TÜRKÇE'
    ],
    durum: ['Az Kullanılmış', 'İkinci El', 'Yeni'],
    history: ["2024", "2023", "2022", "2021", "2020", "2019", "2018"],
  ),
  CategoryModel(
    categoryname: 'KPSS',
    images: "assets/images/1.png",

    classes: ['ORTA ÖĞRETİM', 'ÖNLİSANS'],
    types: ['DENEME', 'SET', 'TEST'],
    subjects: [
      'KPSS GENEL KÜLTÜR',
      'KPSS',
      'ALS',
      'YDS',
      'KPSS ÖABT',
      'VATANDAŞLIK',
    ],
    durum: ['Az Kullanılmış', 'İkinci El', 'Yeni'],
    history: ["2024", "2023", "2022", "2021", "2020", "2019", "2018"],
  ),
  CategoryModel(
    categoryname: 'ALES',
    images: "assets/images/1.png",
   
    classes: ['ORTA ÖĞRETİM', 'ÖNLİSANS'],
    types: ['DENEME', 'SET', 'TEST'],
    subjects: [
      'SAYISAL',
      'SÖZEL',
    ],
    durum: ['Az Kullanılmış', 'İkinci El', 'Yeni'],
    history: ["2024", "2023", "2022", "2021", "2020", "2019", "2018"],
  ),
  CategoryModel(
    categoryname: 'TUS',
    images: "assets/images/1.png",
   
    classes: ['Tıp Öğrencileri'],
    types: ['DENEME', 'SET', 'TEST'],
    subjects: [
      'ANATOMİ',
      'FİZYOLOJİ',
      'PATOFİZYOLOJİ',
      'FARMAKOLOJİ',
      'KLINIK BILIMLER'
    ],
    durum: ['Az Kullanılmış', 'İkinci El', 'Yeni'],
    history: ["2024", "2023", "2022", "2021", "2020", "2019", "2018"],
  ),
  CategoryModel(
    categoryname: 'ROMAN KİTAPLARI',
    images: "assets/images/2.png", 
   
    classes: ['Genel Okuma'],
    types: ['Roman', 'Kısa Hikaye'],
    subjects: [
      'Klasikler',
      'Modern Edebiyat',
      'Bilim Kurgu',
      'Aşk',
      'Macera',
      'Tarihî Roman',
      'Fantastik',
    ],
    durum: ['Az Kullanılmış', 'İkinci El', 'Yeni'],
    history: ["2024", "2023", "2022", "2021", "2020", "2019", "2018"],
  ),
];
