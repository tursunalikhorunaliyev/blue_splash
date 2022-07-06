class GetUrlUsersPhotos {
  dynamic full;
  dynamic regular;
  dynamic small;
  GetUrlUsersPhotos({required this.full, required this.regular, required this.small });
  factory GetUrlUsersPhotos.fromJson(Map<String, dynamic> json) {
    return GetUrlUsersPhotos(full: json['full'], regular: json['regular'], small: json['small']);
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

class GetPhoto {
  GetUrlUsersPhotos getUrl;
  int height;
  int width;

  GetUser getUser;

  GetPhoto({required this.getUrl, required this.height , required this.width , required this.getUser});
  factory GetPhoto.fromJson(Map<String, dynamic> json) {
    return GetPhoto(
      getUrl: GetUrlUsersPhotos.fromJson(json['urls']),
      height: json['height'],
      width: json['width'],
      getUser: GetUser.fromJson(json['user']),
    );
  }
}

class GetAllUsersPhotos {
  List<GetPhoto> list;
  GetAllUsersPhotos({required this.list});
  factory GetAllUsersPhotos.fromJson(List<dynamic> json) {
    var ListPhotos = json.map((e) => GetPhoto.fromJson(e)).toList();
    return GetAllUsersPhotos(list: ListPhotos);
  }
}
//Diyorbek