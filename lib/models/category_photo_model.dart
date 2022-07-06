import 'dart:convert';

class CtegoryMain {
  List<CategoryesModel> list;
  CtegoryMain({
    required this.list,
  });

  factory CtegoryMain.fromMap(Map<String, dynamic> map) {
    var listTemp = map["results"] as List;
    var list = listTemp.map((e) => CategoryesModel.fromMap(e)).toList();

    return CtegoryMain(list: list);
  }
}

class CategoryesModel {
  String id;
  int height;
  int width;
  UrlsCategory urls;
  GetUserCategory getUserCategory;
  CategoryesModel({
    required this.id,
    required this.urls,
    required this.getUserCategory,
    required this.height,
    required this.width,
  });

  factory CategoryesModel.fromMap(Map<String, dynamic> map) {
    return CategoryesModel(
      id: map['id'],
      height: map['height'],
      width: map['width'],
      urls: UrlsCategory.fromMap(
        map['urls'],
      ),
      getUserCategory: GetUserCategory.fromJson(map['user']),
    );
  }
}

class GetUserCategory {
  dynamic name;
  dynamic username;
  GetUserPhotoCategory getUserPhoto;
  GetUserCategory(
      {required this.name, required this.username, required this.getUserPhoto});
  factory GetUserCategory.fromJson(Map<String, dynamic> json) {
    return GetUserCategory(
      name: json['name'],
      username: json['username'],
      getUserPhoto: GetUserPhotoCategory.fromJson(json['profile_image']),
    );
  }
}

class GetUserPhotoCategory {
  String userphotoUrlSmall;
  String userphotoUrlMedium;
  String userphotoUrlLarge;
  GetUserPhotoCategory(
      {required this.userphotoUrlSmall,
      required this.userphotoUrlMedium,
      required this.userphotoUrlLarge});
  factory GetUserPhotoCategory.fromJson(Map<String, dynamic> json) {
    return GetUserPhotoCategory(
        userphotoUrlSmall: json['small'],
        userphotoUrlMedium: json['medium'],
        userphotoUrlLarge: json['large']);
  }
}

class UrlsCategory {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String small_s3;
  UrlsCategory({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.small_s3,
  });

  factory UrlsCategory.fromMap(Map<String, dynamic> map) {
    return UrlsCategory(
      raw: map['raw'],
      full: map['full'],
      regular: map['regular'],
      small: map['small'],
      thumb: map['thumb'],
      small_s3: map['small_s3'],
    );
  }
}
