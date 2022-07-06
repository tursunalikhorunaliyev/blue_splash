import 'dart:convert';

class CakesMain {
  List<Cakes> list;
  CakesMain({
    required this.list,
  });

  factory CakesMain.fromMap(Map<String, dynamic> map) {
    var listTemp = map["results"] as List;
    var list = listTemp.map((e) => Cakes.fromMap(e)).toList();
    
    return CakesMain(list: list);
  }
}

class Cakes {
  String id;
  Urls urls;
  Cakes({
    required this.id,
    required this.urls,
  });
 





  factory Cakes.fromMap(Map<String, dynamic> map) {
    return Cakes(
      id: map['id'],
      urls: Urls.fromMap(map['urls']),
    );
  }


}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String small_s3;
  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.small_s3,
  });

  factory Urls.fromMap(Map<String, dynamic> map) {
    return Urls(
      raw: map['raw'],
      full: map['full'],
      regular: map['regular'],
      small: map['small'],
      thumb: map['thumb'],
      small_s3: map['small_s3'],
    );
  }
}
