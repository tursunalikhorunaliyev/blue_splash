import 'dart:async';
import 'dart:convert';
import 'package:blue_splash/models/latest_photo_model.dart';
import 'package:http/http.dart' as http;

enum UnsplashActionsLatestPhotos { show }

class LatestPhotosBloCUnsplash {
  final getAll = StreamController<List<GetPhotoLatest>>.broadcast();
  final unsplashAction =
      StreamController<UnsplashActionsLatestPhotos>.broadcast();
  StreamSink<List<GetPhotoLatest>> get sink => getAll.sink;
  Stream<List<GetPhotoLatest>> get stream => getAll.stream;
  StreamSink<UnsplashActionsLatestPhotos> get actionSink => unsplashAction.sink;
  Stream<UnsplashActionsLatestPhotos> get actionStream => unsplashAction.stream;

  LatestPhotosBloCUnsplash() {
    int index = 0;
    List<GetPhotoLatest> list = [];

    actionStream.listen((event) async {
      if (event == UnsplashActionsLatestPhotos.show) {
        index++;
        await getPhotoListUsers(index).then((value) {
          list += value.list;
          sink.add(list);
        });
      }
    });
  }

  Future<GetAllLatesPhotos> getPhotoListUsers(index) async {
    http.Response response = await http.get(Uri.parse(
        "https://api.unsplash.com/photos?page=$index&per_page=10&client_id=3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"));
    print("hello world");
    return GetAllLatesPhotos.fromJson(jsonDecode(response.body));
  }
}
