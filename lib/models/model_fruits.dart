import 'dart:convert';



class FruitsMain {
  List<Fruits> list;
  FruitsMain({
    required this.list,
  });

  factory FruitsMain.fromMap(Map<String, dynamic> map) {
    var listTemp = map["results"] as List;
    var list = listTemp.map((e) => Fruits.fromMap(e)).toList();
    
    return FruitsMain(list: list);
  }
}

class Fruits {
  String id;
  Urls urls;
  Fruits({
    required this.id,
    required this.urls,
  });

  factory Fruits.fromMap(Map<String, dynamic> map) {
    return Fruits(
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
