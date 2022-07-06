import 'package:flutter/widgets.dart';

class GetCollectionsPhoto {
  dynamic full;
  dynamic small;
  dynamic regular;
  GetCollectionsPhoto({required this.full, required this.small, required this.regular});
  factory GetCollectionsPhoto.fromJson(Map<String, dynamic> json) {
    return GetCollectionsPhoto(full: json['full'], small: json['small'], regular: json['regular']);
  }
}

class GetUser {
  dynamic name;
  dynamic username;
  GetUserPhoto getUserPhoto;
  GetUser(
      {required this.name, required this.username, required this.getUserPhoto});
  factory GetUser.fromJson(Map<String, dynamic> json) {
    return GetUser(
      name: json['name'],
      username: json['username'],
      getUserPhoto: GetUserPhoto.fromJson(json['profile_image']),
    );
  }
}

class GetUserPhoto {
  String userphotoUrlSmall;
  String userphotoUrlMedium;
  String userphotoUrlLarge;
  GetUserPhoto(
      {required this.userphotoUrlSmall,
      required this.userphotoUrlMedium,
      required this.userphotoUrlLarge});
  factory GetUserPhoto.fromJson(Map<String, dynamic> json) {
    return GetUserPhoto(
        userphotoUrlSmall: json['small'],
        userphotoUrlMedium: json['medium'],
        userphotoUrlLarge: json['large']);
  }
}

class GetCoverPhoto {
  int width;
  int height;
  GetCollectionsPhoto coverPhoto;

  GetCoverPhoto(
      {required this.width, required this.height, required this.coverPhoto});
  factory GetCoverPhoto.fromJson(Map<String, dynamic> json) {
    return GetCoverPhoto(
      width: json["width"],
      height: json["height"],
      coverPhoto: GetCollectionsPhoto.fromJson(json['urls']),
    );
  }
}

class GetPhoto {
  String id;
  String title;
  int totalPhotos;

  GetCoverPhoto getCoverPhotoUrl;

  GetUser getUser;

  GetPhoto(
      {required this.id,
      required this.title,
      required this.totalPhotos,
      required this.getCoverPhotoUrl,
      required this.getUser});
  factory GetPhoto.fromJson(Map<String, dynamic> json) {
    return GetPhoto(
      id: json["id"],
      title: json["title"],
      totalPhotos: json["total_photos"],
      getCoverPhotoUrl: GetCoverPhoto.fromJson(json['cover_photo']),
      getUser: GetUser.fromJson(json['user']),
    );
  }
}

class GetAllCollectionsPhotos {
  List<GetPhoto> list;
  GetAllCollectionsPhotos({required this.list});
  factory GetAllCollectionsPhotos.fromJson(List<dynamic> json) {
    var listPhotos = json.map((e) => GetPhoto.fromJson(e)).toList();
    return GetAllCollectionsPhotos(list: listPhotos);
  }
}