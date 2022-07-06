import 'dart:convert';

class DrinksMain {
  List<Drinks> list;
  DrinksMain({
    required this.list,
  });

  factory DrinksMain.fromMap(Map<String, dynamic> map) {
    var listTemp = map["results"] as List;
    var list = listTemp.map((e) => Drinks.fromMap(e)).toList();

    return DrinksMain(list: list);
  }
}

class Drinks {
  String id;
  Urls urls;
  Drinks({
    required this.id,
    required this.urls,
  });

  factory Drinks.fromMap(Map<String, dynamic> map) {
    return Drinks(
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
