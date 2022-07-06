import 'dart:async';
import 'dart:convert';
import 'package:blue_splash/models/collections_photo_model.dart';
import 'package:http/http.dart' as http;

enum UnsplashActionsCollectionsPhotos { show }

class CollectionsPhotosBloCUnsplash {
  final getAll = StreamController<GetAllCollectionsPhotos>.broadcast();
  final unsplashAction =
      StreamController<UnsplashActionsCollectionsPhotos>.broadcast();
  StreamSink<GetAllCollectionsPhotos> get sink => getAll.sink;
  Stream<GetAllCollectionsPhotos> get stream => getAll.stream;
  StreamSink<UnsplashActionsCollectionsPhotos> get actionSink =>
      unsplashAction.sink;
  Stream<UnsplashActionsCollectionsPhotos> get actionStream =>
      unsplashAction.stream;

  CollectionsPhotosBloCUnsplash() {
    actionStream.listen((event) async {
      if (event == UnsplashActionsCollectionsPhotos.show) {
        sink.add(await getPhotoListUsers());
      }
    });
  }

  Future<GetAllCollectionsPhotos> getPhotoListUsers() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.unsplash.com/collections?page=1&per_page=10&client_id=3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"));
    print("hello world" + response.body);
    return GetAllCollectionsPhotos.fromJson(jsonDecode(response.body));
  }
}
