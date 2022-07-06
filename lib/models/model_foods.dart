import 'dart:convert';

class FoodsMain {
  List<Foods> list;
  FoodsMain({
    required this.list,
  });

  factory FoodsMain.fromMap(Map<String, dynamic> map) {
    var listTemp = map["results"] as List;
    var list = listTemp.map((e) => Foods.fromMap(e)).toList();

    return FoodsMain(list: list);
  }
}

class Foods {
  String id;
  Urls urls;
  Foods({
    required this.id,
    required this.urls,
  });

  factory Foods.fromMap(Map<String, dynamic> map) {
    return Foods(
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
