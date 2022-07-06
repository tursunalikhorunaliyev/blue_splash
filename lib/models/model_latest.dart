import 'dart:convert';

class LatestMain {
  List<LatestModel> list;
  LatestMain({
    required this.list,
  });

  factory LatestMain.fromMap(List<dynamic> map) {
    var listConvert = map.map((e) => LatestModel.fromMap(e)).toList();
    return LatestMain(list: listConvert);
  }
}

class LatestModel {
  String id;
  int height;
  int width;
  Urls urls;
  LatestModel({
    required this.id,
    required this.urls,
    required this.height,
    required this.width,
  });

  factory LatestModel.fromMap(Map<String, dynamic> map) {
    return LatestModel(
      id: map['id'],
      height: map['height'],
      width: map['width'],
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
