// 1ta rasm ma'lumotlari uchun
class PhotoStatMain {
  int width;
  int height;
  int likes;
  int views;
  int downloads;
  PhotoStatUrls photoStatUrls;
  PhotoStatLinks photoStatLinks;
  PhotoStatUser photoStatUser;
  Exif exif;
  PhotoStatMain({
    required this.width,
    required this.height,
    required this.likes,
    required this.views,
    required this.downloads,
    required this.photoStatUrls,
    required this.photoStatLinks,
    required this.photoStatUser,
    required this.exif,
  });

  factory PhotoStatMain.fromMap(Map<String, dynamic> map) {
    return PhotoStatMain(
      width: map['width'],
      height: map['height'],
      likes: map['likes'],
      views: map['views'],
      downloads: map['downloads'],
      photoStatUrls: PhotoStatUrls.fromMap(map['urls']),
      photoStatLinks: PhotoStatLinks.fromMap(map['links']),
      photoStatUser: PhotoStatUser.fromMap(map['user']),
      exif: Exif.fromMap(map['exif']),
    );
  }
}

class PhotoStatUrls {
  String regular;
  PhotoStatUrls({
    required this.regular,
  });
  factory PhotoStatUrls.fromMap(Map<String, dynamic> map) {
    return PhotoStatUrls(
      regular: map['regular'],
    );
  }
}

class PhotoStatLinks {
  String download;
  PhotoStatLinks({
    required this.download,
  });

  factory PhotoStatLinks.fromMap(Map<String, dynamic> map) {
    return PhotoStatLinks(
      download: map['download'],
    );
  }
}

class PhotoStatUser {
  String name;
  String username;
  PhotoStatProfileImage photoStatProfileImage;
  PhotoStatUser({
    required this.name,
    required this.photoStatProfileImage,
    required this.username,
  });

  factory PhotoStatUser.fromMap(Map<String, dynamic> map) {
    return PhotoStatUser(
      name: map['name'],
      username: map['username'],
      photoStatProfileImage:
          PhotoStatProfileImage.fromMap(map['profile_image']),
    );
  }
}

class PhotoStatProfileImage {
  String large;
  PhotoStatProfileImage({
    required this.large,
  });

  factory PhotoStatProfileImage.fromMap(Map<String, dynamic> map) {
    return PhotoStatProfileImage(
      large: map['large'],
    );
  }
}

class Exif {
  dynamic model;
  dynamic focalLength;
  dynamic iso;
  dynamic aperture;
  dynamic exposureTime;
  Exif({
    required this.model,
    required this.focalLength,
    required this.iso,
    required this.aperture,
    required this.exposureTime,
  });

  factory Exif.fromMap(Map<String, dynamic> map) {
    return Exif(
      model: map['model'],
      focalLength: map['focal_length'],
      iso: map['iso'],
      aperture: map['aperture'],
      exposureTime: map['exposure_time'],
    );
  }
}

// 1ta rasm ma'lumotlari tugadi

// 'User Followers'lari
class FollowerProfileImage {
  String medium;
  FollowerProfileImage({
    required this.medium,
  });

  factory FollowerProfileImage.fromMap(Map<String, dynamic> map) {
    return FollowerProfileImage(
      medium: map['medium'],
    );
  }
}

class FollowersMain {
  String username;
  String name;
  int totalPhotos;
  FollowerProfileImage followerProfileImage;
  FollowersMain({
    required this.username,
    required this.name,
    required this.totalPhotos,
    required this.followerProfileImage,
  });

  factory FollowersMain.fromMap(Map<String, dynamic> map) {
    return FollowersMain(
      username: map['username'],
      name: map['name'],
      totalPhotos: map['total_photos'],
      followerProfileImage: FollowerProfileImage.fromMap(map['profile_image']),
    );
  }
}

class ListFollowers {
  List<FollowersMain> followers;
  ListFollowers({
    required this.followers,
  });

  factory ListFollowers.fromMap(List<dynamic> map) {
    var list = map.map((e) => FollowersMain.fromMap(e)).toList();
    return ListFollowers(
      followers: list,
    );
  }
}

class UserFol {
  String name;
  UserFolImg userFolImg;
  UserFol({required this.name, required this.userFolImg});

  factory UserFol.fromMap(Map<String, dynamic> map) {
    return UserFol(
        name: map['name'],
        userFolImg: UserFolImg.fromMap(map['profile_image']));
  }
}

class UserFolImg {
  String large;
  UserFolImg({
    required this.large,
  });

  factory UserFolImg.fromMap(Map<String, dynamic> map) {
    return UserFolImg(
      large: map['large'],
    );
  }
}

// 'User Followers'lari tugadi

// 'User Collection'lari

class ProfileUserOwnCol {
  String medium;
  ProfileUserOwnCol({
    required this.medium,
  });

  factory ProfileUserOwnCol.fromMap(Map<String, dynamic> map) {
    return ProfileUserOwnCol(
      medium: map['medium'],
    );
  }
}

class UserOwnCol {
  String name;
  ProfileUserOwnCol profileUserOwnCol;
  UserOwnCol({
    required this.name,
    required this.profileUserOwnCol,
  });

  factory UserOwnCol.fromMap(Map<String, dynamic> map) {
    return UserOwnCol(
      name: map['name'],
      profileUserOwnCol: ProfileUserOwnCol.fromMap(map['profile_image']),
    );
  }
}

class UrlCoverOwnCol {
  String regular;
  UrlCoverOwnCol({
    required this.regular,
  });

  factory UrlCoverOwnCol.fromMap(Map<String, dynamic> map) {
    return UrlCoverOwnCol(
      regular: map['regular'],
    );
  }
}

class CoverOwnCol {
  UrlCoverOwnCol urlCoverOwnCol;
  CoverOwnCol({
    required this.urlCoverOwnCol,
  });

  factory CoverOwnCol.fromMap(Map<String, dynamic> map) {
    return CoverOwnCol(
      urlCoverOwnCol: UrlCoverOwnCol.fromMap(map['urls']),
    );
  }
}

class ListTags {
  List<Tags> tags;
  ListTags({
    required this.tags,
  });

  factory ListTags.fromMap(List<dynamic> map) {
    return ListTags(
      tags: map.map((e) => Tags.fromMap(e)).toList(),
    );
  }
}

class Tags {
  SourceTag? sourceTag;
  Tags({
    required this.sourceTag,
  });

  factory Tags.fromMap(Map<String, dynamic> map) {
    if (map['source'] != null) {
      return Tags(
        sourceTag: SourceTag.fromMap(map['source']),
      );
    } else {
      return Tags(
        sourceTag: null,
      );
    }
  }
}

class SourceTag {
  AncentryTag ancentryTag;
  SourceTag({
    required this.ancentryTag,
  });

  factory SourceTag.fromMap(Map<String, dynamic> map) {
    return SourceTag(
      ancentryTag: AncentryTag.fromMap(map['ancestry']),
    );
  }
}

class AncentryTag {
  TypeTag typeTag;
  AncentryTag({
    required this.typeTag,
  });

  factory AncentryTag.fromMap(Map<String, dynamic> map) {
    return AncentryTag(
      typeTag: TypeTag.fromMap(map['type']),
    );
  }
}

class TypeTag {
  String slug;
  TypeTag({
    required this.slug,
  });
  factory TypeTag.fromMap(Map<String, dynamic> map) {
    return TypeTag(
      slug: map['slug'],
    );
  }
}

class OwnCol {
  String id;
  dynamic title;
  int totalPhotos;
  CoverOwnCol coverOwnCol;
  UserOwnCol userOwnCol;
  ListTags listTags;

  OwnCol({
    required this.id,
    required this.title,
    required this.totalPhotos,
    required this.coverOwnCol,
    required this.userOwnCol,
    required this.listTags,
  });

  factory OwnCol.fromMap(Map<String, dynamic> map) {
    return OwnCol(
      id: map['id'],
      title: map['title'],
      totalPhotos: map['total_photos'],
      coverOwnCol: CoverOwnCol.fromMap(map['cover_photo']),
      userOwnCol: UserOwnCol.fromMap(map['user']),
      listTags: ListTags.fromMap(map['tags']),
    );
  }
}

class ListOwnCol {
  List<OwnCol> listOwnCol;
  ListOwnCol({
    required this.listOwnCol,
  });

  factory ListOwnCol.fromMap(List<dynamic> map) {
    var list = map.map((e) => OwnCol.fromMap(e)).toList();
    return ListOwnCol(listOwnCol: list);
  }
}

// 'User Collection'lari tugadi

// Userni umumiy kolleksiyasi

class PublicColUser {
  String id;
  String username;
  String name;
  PublicColUserImage publicColUserImage;
  PublicColUser({
    required this.id,
    required this.username,
    required this.name,
    required this.publicColUserImage,
  });

  factory PublicColUser.fromMap(Map<String, dynamic> map) {
    return PublicColUser(
      id: map['id'],
      username: map['username'],
      name: map['name'],
      publicColUserImage: PublicColUserImage.fromMap(map['profile_image']),
    );
  }
}

class PublicColUserImage {
  String medium;
  PublicColUserImage({
    required this.medium,
  });

  factory PublicColUserImage.fromMap(Map<String, dynamic> map) {
    return PublicColUserImage(
      medium: map['medium'],
    );
  }
}

class PublicColUrls {
  String regular;
  PublicColUrls({
    required this.regular,
  });
  factory PublicColUrls.fromMap(Map<String, dynamic> map) {
    return PublicColUrls(
      regular: map['regular'],
    );
  }
}

class PublicCol {
  String id;
  int width;
  int height;
  PublicColUrls publicColUrls;
  PublicColUser publicColUser;
  PublicCol({
    required this.id,
    required this.publicColUrls,
    required this.publicColUser,
    required this.height,
    required this.width,
  });

  factory PublicCol.fromMap(Map<String, dynamic> map) {
    return PublicCol(
      id: map['id'],
      publicColUrls: PublicColUrls.fromMap(map['urls']),
      publicColUser: PublicColUser.fromMap(map['user']),
      height: map['height'],
      width: map['width'],
    );
  }
}

class ListPublicCol {
  List<PublicCol> listCol;
  ListPublicCol({
    required this.listCol,
  });

  factory ListPublicCol.fromMap(List<dynamic> map) {
    var list = map.map((x) => PublicCol.fromMap(x)).toList();
    return ListPublicCol(
      listCol: list,
    );
  }
}

// Userni umumiy kolleksiyasi tugadi

// Random rasmlarni olib kelish

class ListRandomPhotos {
  List<RandomPhotos> list;
  ListRandomPhotos({
    required this.list,
  });

  factory ListRandomPhotos.fromMap(List<dynamic> map) {
    var listMap = map.map((e) => RandomPhotos.fromMap(e)).toList();
    return ListRandomPhotos(
      list: listMap,
    );
  }
}

class RandomPhotos {
  String id;
  int width;
  int height;
  RandomPhotoUser randomPhotoUser;
  RandomPhotoUrls randomPhotoUrls;
  RandomPhotos({
    required this.id,
    required this.randomPhotoUser,
    required this.randomPhotoUrls,
    required this.height,
    required this.width,
  });

  factory RandomPhotos.fromMap(Map<String, dynamic> map) {
    return RandomPhotos(
      id: map['id'],
      randomPhotoUser: RandomPhotoUser.fromMap(map['user']),
      randomPhotoUrls: RandomPhotoUrls.fromMap(map['urls']),
      height: map['height'],
      width: map['width'],
    );
  }
}

class RandomPhotoUrls {
  String regular;
  RandomPhotoUrls({
    required this.regular,
  });

  factory RandomPhotoUrls.fromMap(Map<String, dynamic> map) {
    return RandomPhotoUrls(
      regular: map['regular'],
    );
  }
}

class RandomPhotoUser {
  String id;
  String username;
  String name;
  RandomPhotoUserPhoto randomPhotoUserPhoto;
  RandomPhotoUser({
    required this.id,
    required this.username,
    required this.name,
    required this.randomPhotoUserPhoto,
  });

  factory RandomPhotoUser.fromMap(Map<String, dynamic> map) {
    return RandomPhotoUser(
        id: map['id'],
        username: map['username'],
        name: map['name'],
        randomPhotoUserPhoto:
            RandomPhotoUserPhoto.fromMap(map['profile_image']));
  }
}

class RandomPhotoUserPhoto {
  String medium;
  RandomPhotoUserPhoto({
    required this.medium,
  });

  factory RandomPhotoUserPhoto.fromMap(Map<String, dynamic> map) {
    return RandomPhotoUserPhoto(
      medium: map['medium'],
    );
  }
}

// Rasmlarni Random olib kelish tugadi

// Rasmlarni tag orqali olib kelish

class ListTagPhotos {
  List<TagPhotos> tagPhotos;
  ListTagPhotos({
    required this.tagPhotos,
  });

  factory ListTagPhotos.fromMap(List<dynamic> map) {
    var list = map.map((e) => TagPhotos.fromMap(e)).toList();
    return ListTagPhotos(
      tagPhotos: list,
    );
  }
}

class TagPhotos {
  int width;
  int height;
  String id;
  TagPhotoUrls tagPhotoUrls;
  TagPhotoUser tagPhotoUser;
  TagPhotos({
    required this.id,
    required this.tagPhotoUrls,
    required this.tagPhotoUser,
    required this.height,
    required this.width,
  });

  factory TagPhotos.fromMap(Map<String, dynamic> map) {
    return TagPhotos(
      id: map['id'],
      tagPhotoUrls: TagPhotoUrls.fromMap(map['urls']),
      tagPhotoUser: TagPhotoUser.fromMap(map['user']),
      height: map['height'],
      width: map['width'],
    );
  }
}

class TagPhotoUrls {
  String regular;
  TagPhotoUrls({
    required this.regular,
  });

  factory TagPhotoUrls.fromMap(Map<String, dynamic> map) {
    return TagPhotoUrls(
      regular: map['regular'],
    );
  }
}

class TagPhotoUser {
  String id;
  String username;
  String name;
  TagPhotoUserProfileImage tagPhotoUserProfileImage;
  TagPhotoUser({
    required this.id,
    required this.username,
    required this.name,
    required this.tagPhotoUserProfileImage,
  });

  factory TagPhotoUser.fromMap(Map<String, dynamic> map) {
    return TagPhotoUser(
      id: map['id'],
      username: map['username'],
      name: map['name'],
      tagPhotoUserProfileImage:
          TagPhotoUserProfileImage.fromMap(map['profile_image']),
    );
  }
}

class TagPhotoUserProfileImage {
  String medium;
  TagPhotoUserProfileImage({
    required this.medium,
  });

  factory TagPhotoUserProfileImage.fromMap(Map<String, dynamic> map) {
    return TagPhotoUserProfileImage(
      medium: map['medium'],
    );
  }
}

// Rasmlarni tag orqali olib kelish tugadi