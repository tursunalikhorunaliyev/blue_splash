class GetLatestPhoto {
  dynamic full;
  dynamic small;
  dynamic regular;
  GetLatestPhoto(
      {required this.full, required this.small, required this.regular});
  factory GetLatestPhoto.fromJson(Map<String, dynamic> json) {
    return GetLatestPhoto(
        full: json['full'], small: json['small'], regular: json['regular']);
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

class GetPhotoLatest {
  String id;
  GetLatestPhoto getUrl;
  int height;
  int width;
  GetUser getUser;

  GetPhotoLatest({
    required this.id,
    required this.getUrl,
    required this.getUser,
    required this.height,
    required this.width,
  });
  factory GetPhotoLatest.fromJson(Map<String, dynamic> json) {
    return GetPhotoLatest(
      id: json['id'],
      height: json['height'],
      width: json['width'],
      getUrl: GetLatestPhoto.fromJson(json['urls']),
      getUser: GetUser.fromJson(json['user']),
    );
  }
}

class GetAllLatesPhotos {
  List<GetPhotoLatest> list;
  GetAllLatesPhotos({required this.list});
  factory GetAllLatesPhotos.fromJson(List<dynamic> json) {
    var ListPhotos = json.map((e) => GetPhotoLatest.fromJson(e)).toList();
    return GetAllLatesPhotos(list: ListPhotos);
  }
}



//Diyorbek