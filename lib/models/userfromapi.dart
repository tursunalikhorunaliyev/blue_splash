import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EEEngKattaClass {
  dynamic username;
  dynamic name;
  dynamic bio;
  dynamic location;
  int followers_count;
  int following_count;
  int downloads;
  int total_collections;
  int total_photos;
  int total_likes;
  Badge? badge;
  Tags tags;

  ProfileImage profileImage;
  EEEngKattaClass({
    required this.tags,
    required this.badge,
    required this.username,
    required this.name,
    required this.bio,
    required this.location,
    required this.followers_count,
    required this.following_count,
    required this.downloads,
    required this.total_collections,
    required this.total_photos,
    required this.total_likes,
    required this.profileImage,
  });

  factory EEEngKattaClass.fromMap(Map<String, dynamic> map) {
    if (map['badge'] != null) {
      return EEEngKattaClass(
        tags: Tags.fromMap(map['tags']),
        badge: Badge.fromMap(map['badge']),
        username: map['username'],
        name: map['name'],
        bio: map['bio'],
        location: map['location'],
        followers_count: map['followers_count'],
        following_count: map['following_count'],
        downloads: map['downloads'],
        total_collections: map['total_collections'],
        total_photos: map['total_photos'],
        total_likes: map['total_likes'],
        profileImage: ProfileImage.fromMap(map['profile_image']),
      );
    } else {
      return EEEngKattaClass(
        tags: Tags.fromMap(map['tags']),
        badge: null,
        username: map['username'],
        name: map['name'],
        bio: map['bio'],
        location: map['location'],
        followers_count: map['followers_count'],
        following_count: map['following_count'],
        downloads: map['downloads'],
        total_collections: map['total_collections'],
        total_photos: map['total_photos'],
        total_likes: map['total_likes'],
        profileImage: ProfileImage.fromMap(map['profile_image']),
      );
    }
  }
}

class ProfileImage {
  String medium;
  ProfileImage({
    required this.medium,
  });

  factory ProfileImage.fromMap(Map<String, dynamic> map) {
    return ProfileImage(
      medium: map['medium'],
    );
  }
}

class Badge {
  dynamic title;
  Badge({
    required this.title,
  });

  factory Badge.fromMap(Map<String, dynamic>? map) {
    return Badge(
      title: map!['title'],
    );
  }
}

/* class Tags {
  List<> custom;
  
  } */

//Photos
class Photos {
  List<PhotosClasses> list;
  Photos({
    required this.list,
  });

  factory Photos.fromMap(List<dynamic> map) {
    var list = map.map((e) => PhotosClasses.fromMap(e)).toList();
    return Photos(list: list);
  }
}

class UrlsProg {
  dynamic regular;
  UrlsProg({
    required this.regular,
  });

  factory UrlsProg.fromMap(Map<String, dynamic> map) {
    return UrlsProg(
      regular: map['regular'],
    );
  }
}

class LinksProg {
  dynamic download;
  LinksProg({
    required this.download,
  });

  factory LinksProg.fromMap(Map<String, dynamic> map) {
    return LinksProg(
      download: map['download'],
    );
  }
}

class PhotosClasses {
  UrlsProg urls;
  LinksProg links;
  PhotosClasses({
    required this.urls,
    required this.links,
  });

  factory PhotosClasses.fromMap(Map<String, dynamic> map) {
    return PhotosClasses(
      urls: UrlsProg.fromMap(map['urls'] as Map<String, dynamic>),
      links: LinksProg.fromMap(map['links'] as Map<String, dynamic>),
    );
  }
}

class ListCollection {
  List<UserCollection> list;
  ListCollection({
    required this.list,
  });

  factory ListCollection.fromMap(List<dynamic> map) {
    var list = map.map((e) => UserCollection.fromMap(e)).toList();
    return ListCollection(list: list);
  }
}

class UserCollection {
  CollectionCoverPhoto cover_photo;
  UserCollection({
    required this.cover_photo,
  });

  factory UserCollection.fromMap(Map<String, dynamic> map) {
    return UserCollection(
      cover_photo: CollectionCoverPhoto.fromMap(
          map['cover_photo'] as Map<String, dynamic>),
    );
  }
}

class CollectionCoverPhoto {
  CollectionUrls urls;
  CollectionCoverPhoto({
    required this.urls,
  });

  factory CollectionCoverPhoto.fromMap(Map<String, dynamic> map) {
    return CollectionCoverPhoto(
      urls: CollectionUrls.fromMap(map['urls']),
    );
  }
}

class CollectionUrls {
  dynamic regular;
  CollectionUrls({
    required this.regular,
  });

  factory CollectionUrls.fromMap(Map<String, dynamic> map) {
    return CollectionUrls(
      regular: map['regular'],
    );
  }
}

class ListUserPhotos {
  List<UserPhotosProg> list;
  ListUserPhotos({
    required this.list,
  });

  factory ListUserPhotos.fromMap(List<dynamic> map) {
    var list = map.map((e) => UserPhotosProg.fromMap(e)).toList();
    return ListUserPhotos(list: list);
  }
}

class UserPhotosProg {
  UserPhotoUrls urls;
  UserPhotosProg({
    required this.urls,
  });

  factory UserPhotosProg.fromMap(Map<String, dynamic> map) {
    return UserPhotosProg(
      urls: UserPhotoUrls.fromMap(map['urls'] as Map<String, dynamic>),
    );
  }
}

class UserPhotoUrls {
  dynamic regular;
  UserPhotoUrls({
    required this.regular,
  });

  factory UserPhotoUrls.fromMap(Map<String, dynamic> map) {
    return UserPhotoUrls(
      regular: map['regular'],
    );
  }
}

class ListFollower {
  List<UserFollowers> list;

  ListFollower({required this.list});

  factory ListFollower.fromMap(List<dynamic> map) {
    var list = map.map((e) => UserFollowers.fromMap(e)).toList();
    return ListFollower(list: list);
  }
}

class UserFollowers {
  String username;
  FollowerImage profile_image;
  UserFollowers({
    required this.username,
    required this.profile_image,
  });

  factory UserFollowers.fromMap(Map<String, dynamic> map) {
    return UserFollowers(
      username: map['username'],
      profile_image: FollowerImage.fromMap(map['profile_image']),
    );
  }
}

class FollowerImage {
  dynamic medium;
  FollowerImage({
    required this.medium,
  });

  factory FollowerImage.fromMap(Map<String, dynamic> map) {
    return FollowerImage(
      medium: map['medium'],
    );
  }
}

class Tags {
  List<UpSource> custom;
  List<AgrUpSource> aggregated;
  Tags({
    required this.aggregated,
    required this.custom,
  });

  factory Tags.fromMap(Map<String, dynamic> map) {
    var listObject = map["custom"] as List;
    var list = listObject.map((e) => UpSource.fromMap(e)).toList();
    var listObjectAgr = map["aggregated"] as List;
    var listagr = listObjectAgr.map((e) => AgrUpSource.fromMap(e)).toList();
    return Tags(aggregated: listagr, custom: list);
  }
}

class UpSource {
  String title;
  Source? source;
  UpSource({
    required this.title,
    required this.source,
  });

  factory UpSource.fromMap(Map<String, dynamic> map) {
    if (map["source"] != null) {
      return UpSource(
        title: map['type'] as String,
        source: Source.fromMap(map['source']),
      );
    } else {
      return UpSource(
        title: map['type'] as String,
        source: null,
      );
    }
  }
}

class Source {
  Ancestry? ancestry;
  Source({
    required this.ancestry,
  });

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      ancestry: Ancestry.fromMap(map['ancestry'] as Map<String, dynamic>),
    );
  }
}

class Ancestry {
  TypeSlug? type;
  Category? category;
  SubCategory? subCategory;
  Ancestry(
      {required this.type, required this.category, required this.subCategory});

  factory Ancestry.fromMap(Map<String, dynamic> map) {
    if (map['category'] == null) {
      return Ancestry(
          type: TypeSlug.fromMap(map['type']),
          category: null,
          subCategory: null);
    } else if (map['category'] != null && map['subcategory'] == null) {
      return Ancestry(
          type: TypeSlug.fromMap(map['type']),
          category: Category.fromMap(map['category']),
          subCategory: null);
    } else {
      return Ancestry(
          type: TypeSlug.fromMap(map['type']),
          category: Category.fromMap(map['category']),
          subCategory: SubCategory.fromMap(map['subcategory']));
    }
  }
}

class TypeSlug {
  String slug;
  TypeSlug({
    required this.slug,
  });

  factory TypeSlug.fromMap(Map<String, dynamic> map) {
    return TypeSlug(
      slug: map['slug'] as String,
    );
  }
}

class Category {
  String? slug;
  Category({
    required this.slug,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      slug: map['slug'] as String,
    );
  }
}

class SubCategory {
  String? slug;
  SubCategory({
    required this.slug,
  });

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      slug: map['slug'] as String,
    );
  }
}

class AgrUpSource {
  String title;
  SourceAgr? source;
  AgrUpSource({
    required this.title,
    required this.source,
  });

  factory AgrUpSource.fromMap(Map<String, dynamic> map) {
    if (map["source"] != null) {
      return AgrUpSource(
        title: map['type'] as String,
        source: SourceAgr.fromMap(map['source']),
      );
    } else {
      return AgrUpSource(
        title: map['type'] as String,
        source: null,
      );
    }
  }
}

class SourceAgr {
  AncestryAgr? ancestry;
  SourceAgr({
    required this.ancestry,
  });

  factory SourceAgr.fromMap(Map<String, dynamic> map) {
    return SourceAgr(
      ancestry: AncestryAgr.fromMap(map['ancestry'] as Map<String, dynamic>),
    );
  }
}

class AncestryAgr {
  TypeSlugAgr? type;
  CategoryAgr? category;
  SubCategoryAgr? subCategory;
  AncestryAgr(
      {required this.type, required this.category, required this.subCategory});

  factory AncestryAgr.fromMap(Map<String, dynamic> map) {
    if (map['category'] == null) {
      return AncestryAgr(
          type: TypeSlugAgr.fromMap(map['type']),
          category: null,
          subCategory: null);
    } else if (map['category'] != null && map['subcategory'] == null) {
      return AncestryAgr(
          type: TypeSlugAgr.fromMap(map['type']),
          category: CategoryAgr.fromMap(map['category']),
          subCategory: null);
    } else {
      return AncestryAgr(
          type: TypeSlugAgr.fromMap(map['type']),
          category: CategoryAgr.fromMap(map['category']),
          subCategory: SubCategoryAgr.fromMap(map['subcategory']));
    }
  }
}

class TypeSlugAgr {
  String slug;
  TypeSlugAgr({
    required this.slug,
  });

  factory TypeSlugAgr.fromMap(Map<String, dynamic> map) {
    return TypeSlugAgr(
      slug: map['slug'] as String,
    );
  }
}

class CategoryAgr {
  String? slug;
  CategoryAgr({
    required this.slug,
  });

  factory CategoryAgr.fromMap(Map<String, dynamic> map) {
    return CategoryAgr(
      slug: map['slug'] as String,
    );
  }
}

class SubCategoryAgr {
  String? slug;
  SubCategoryAgr({
    required this.slug,
  });

  factory SubCategoryAgr.fromMap(Map<String, dynamic> map) {
    return SubCategoryAgr(
      slug: map['slug'] as String,
    );
  }
}
