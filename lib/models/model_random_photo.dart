import 'dart:convert';

class RandomMain {
  List<Random> list;
  RandomMain({
    required this.list,
  });

  factory RandomMain.fromMap(List<dynamic> map) {
    var listConvert = map.map((e) => Random.fromMap(e)).toList();
    return RandomMain(list: listConvert);
  }
}

class Random {
  String id;
  Urls urls;
  Random({
    required this.id,
    required this.urls,
  });

  factory Random.fromMap(Map<String, dynamic> map) {
    return Random(
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
