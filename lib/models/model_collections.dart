import 'dart:convert';

class CollectionsMain {
  List<CollectionsModel> list;
  CollectionsMain({
    required this.list,
  });

  factory CollectionsMain.fromMap(List<dynamic> map) {
    var listConvert = map.map((e) => CollectionsModel.fromMap(e)).toList();
    return CollectionsMain(list: listConvert);
  }
}

class CollectionsModel {
  String id;
  String title;
  int totalPhotos;
  User user;
  CoverPhoto coverPhoto;
  CollectionsModel({
    required this.id,
    required this.title,
    required this.totalPhotos,
    required this.user,
    required this.coverPhoto,
  });

  factory CollectionsModel.fromMap(Map<String, dynamic> map) {
    return CollectionsModel(
      id: map['id'],
      title: map['title'],
      totalPhotos: map['total_photos'],
      user: User.fromMap(map["user"]),
      coverPhoto: CoverPhoto.fromMap(map['cover_photo']),
    );
  }
}

class CoverPhoto {
  Urls urls;
  CoverPhoto({
    required this.urls,
  });

  factory CoverPhoto.fromMap(Map<String, dynamic> map) {
    return CoverPhoto(
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

class User {
  String username;
  User({
    required this.username,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
    );
  }
}