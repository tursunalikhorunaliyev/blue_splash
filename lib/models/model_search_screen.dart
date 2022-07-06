import 'dart:convert';

class ModelSearchScreenMain {
  List<ModelSearchScreen> list;
  ModelSearchScreenMain({
    required this.list,
  });

  factory ModelSearchScreenMain.fromMap(Map<String, dynamic> map) {
    var listTemp = map["results"] as List;
    var list = listTemp.map((e) => ModelSearchScreen.fromMap(e)).toList();

    return ModelSearchScreenMain(list: list);
  }
}

class ModelSearchScreen {
  String id;
  Urls urls;
  ModelSearchScreen({
    required this.id,
    required this.urls,
  });

  factory ModelSearchScreen.fromMap(Map<String, dynamic> map) {
    return ModelSearchScreen(
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
