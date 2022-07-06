// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TagList {
  List<TagPhotoKatta> list;
  TagList({
    required this.list,
  });

  factory TagList.fromMap(List<dynamic> map) {
    var list = map.map((e) => TagPhotoKatta.fromMap(e)).toList();
    return TagList(list: list);
  }
}

class TagPhotoKatta {
  UserTag userTag;
  UrlsTagPhoto urlsTagPhoto;
  TagPhotoKatta({
    required this.userTag,
    required this.urlsTagPhoto,
  });

  factory TagPhotoKatta.fromMap(Map<String, dynamic> map) {
    return TagPhotoKatta(
      userTag: UserTag.fromMap(map['user'] as Map<String, dynamic>),
      urlsTagPhoto: UrlsTagPhoto.fromMap(map['urls'] as Map<String, dynamic>),
    );
  }
}

class UserTag {
  String id;
  String username;
  String name;
  UserTagProfImage profile_image;
  UserTag({
    required this.id,
    required this.username,
    required this.name,
    required this.profile_image,
  });

  factory UserTag.fromMap(Map<String, dynamic> map) {
    return UserTag(
      profile_image: UserTagProfImage.fromMap(map['profile_image']),
      id: map['id'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
    );
  }
}

class UserTagProfImage {
  String medium;
  UserTagProfImage({
    required this.medium,
  });

  factory UserTagProfImage.fromMap(Map<String, dynamic> map) {
    return UserTagProfImage(
      medium: map['medium'] as String,
    );
  }
}

class UrlsTagPhoto {
  String regular;
  UrlsTagPhoto({
    required this.regular,
  });

  factory UrlsTagPhoto.fromMap(Map<String, dynamic> map) {
    return UrlsTagPhoto(
      regular: map['regular'] as String,
    );
  }
}
