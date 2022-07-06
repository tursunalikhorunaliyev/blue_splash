import 'dart:async';
import 'dart:convert';
import 'package:blue_splash/models/users_photos_model.dart';
import 'package:http/http.dart' as http;

enum UnsplashActionsPhotos { show }

class UsersPhotosBloCUnsplash {
  final getAll = StreamController<GetAllUsersPhotos>.broadcast();
  final unsplashAction = StreamController<UnsplashActionsPhotos>.broadcast();
  StreamSink<GetAllUsersPhotos> get sink => getAll.sink;
  Stream<GetAllUsersPhotos> get stream => getAll.stream;
  StreamSink<UnsplashActionsPhotos> get actionSink => unsplashAction.sink;
  Stream<UnsplashActionsPhotos> get actionStream => unsplashAction.stream;

  UsersPhotosBloCUnsplash(username) {
    actionStream.listen((event) async {
      if (event == UnsplashActionsPhotos.show) {
        sink.add(await getPhotoListUsers(username));
      }
    });
  }

  Future<GetAllUsersPhotos> getPhotoListUsers(username) async {
    http.Response response = await http.get(Uri.parse(
        "https://api.unsplash.com/users/$username/photos?page=1&per_page=10&stats=true&client_id=3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"));
    print("hello world" + response.body);
    return GetAllUsersPhotos.fromJson(jsonDecode(response.body));
  }
}
