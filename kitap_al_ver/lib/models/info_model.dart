

class InfoModel {
  final List<String> sinif;
  final List<String> durum;
  final List<String> tur;
  final List<String> ders;

  InfoModel(
    this.sinif,
    this.durum,
    this.tur,
    this.ders,
  );
}

final List<InfoModel> bilgi = [
  InfoModel(
    
    ['Sınıf 9', 'Sınıf 10','Sınıf 11','Sınıf 12'],
    ['Az Kullanılmış', 'İkinci El','Yeni'], // Add appropriate values
    ['DENEME', 'SET', 'TEST'], // Add appropriate colors
    [  'BİYOLOJİ',
                  'COĞRAFYA',
                  'EDEBİYAT-DİLBİLGİSİ',
                  'FELSEFE',
                  'FİZİK',
                  'GEOMETRİ',
                  'KİMYA',
                  'PARAGRAF',
                  'TARİH',
                  'TÜRKÇE'], // Add appropriate values
  ),
];
