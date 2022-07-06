import 'dart:async';
import 'dart:convert';
import 'package:blue_splash/models/unsplash_model.dart';
import 'package:http/http.dart' as http;

enum Images { once, follow, own, public, getone, tags, random }

String key = "0UI5Vawmk0ZVZtZcOSOhoNQK8Quv7u-OFaJofjUhP4o";

class GetPhotoStat {
  final eventController = StreamController<Images>.broadcast();
  final dataController = StreamController<PhotoStatMain>.broadcast();

  StreamSink<PhotoStatMain> get dataSink => dataController.sink;
  Stream<PhotoStatMain> get dataStream => dataController.stream;
  StreamSink<Images> get eventSink => eventController.sink;
  Stream<Images> get eventStream => eventController.stream;

  GetPhotoStat(id) {
    eventStream.listen((event) async {
      if (event == Images.once) {
        dataSink.add(await getPhotoStats(id));
      }
    });
  }

  Future<PhotoStatMain> getPhotoStats(id) async {
    var url = "https://api.unsplash.com/photos/$id?client_id=$key";

    http.Response response = await http.get(Uri.parse(url));
    return PhotoStatMain.fromMap(jsonDecode(response.body));
  }
}

class SliverBLoC {
  final streamController = StreamController<bool>.broadcast();
  StreamSink<bool> get sink => streamController.sink;
  Stream<bool> get stream => streamController.stream;
}

class FollowersBLoC {
  final eventController = StreamController<Images>.broadcast();
  final dataFollowerController = StreamController<ListFollowers>.broadcast();
  final dataUserController = StreamController<UserFol>.broadcast();

  StreamSink<ListFollowers> get dataFollowerSink => dataFollowerController.sink;
  Stream<ListFollowers> get dataFollowerStream => dataFollowerController.stream;
  StreamSink<UserFol> get dataUserSink => dataUserController.sink;
  Stream<UserFol> get dataUserStream => dataUserController.stream;
  StreamSink<Images> get eventSink => eventController.sink;
  Stream<Images> get eventStream => eventController.stream;

  FollowersBLoC(username) {
    eventStream.listen((event) async {
      if (event == Images.follow) {
        dataFollowerSink.add(await getFollowers(username));
        dataUserSink.add(await getUser(username));
      }
    });
  }

  Future<UserFol> getUser(username) async {
    var url = "https://api.unsplash.com/users/$username?client_id=$key";
    http.Response response = await http.get(Uri.parse(url));
    return UserFol.fromMap(jsonDecode(response.body));
  }

  Future<ListFollowers> getFollowers(username) async {
    var url =
        "https://api.unsplash.com/users/$username/followers?client_id=$key";

    http.Response response = await http.get(Uri.parse(url));
    return ListFollowers.fromMap(jsonDecode(response.body));
  }
}

class OwnColBLoC {
  final eventController = StreamController<Images>.broadcast();
  final dataController = StreamController<ListOwnCol>.broadcast();

  StreamSink<ListOwnCol> get dataSink => dataController.sink;
  Stream<ListOwnCol> get dataStream => dataController.stream;
  StreamSink<Images> get eventSink => eventController.sink;
  Stream<Images> get eventStream => eventController.stream;

  OwnColBLoC(username) {
    eventStream.listen((event) async {
      if (event == Images.own) {
        dataSink.add(await getPhotoStats(username));
      }
    });
  }

  Future<ListOwnCol> getPhotoStats(username) async {
    var url =
        "https://api.unsplash.com/users/$username/collections?client_id=$key&per_page=30";

    http.Response response = await http.get(Uri.parse(url));
    return ListOwnCol.fromMap(jsonDecode(response.body));
  }
}

class ColBloc {
  final eventController = StreamController<Images>.broadcast();
  final dataController = StreamController<OwnCol>.broadcast();
  final setController = StreamController<List<String>>.broadcast();

  StreamSink<OwnCol> get dataSink => dataController.sink;
  Stream<OwnCol> get dataStream => dataController.stream;
  StreamSink<Images> get eventSink => eventController.sink;
  Stream<Images> get eventStream => eventController.stream;
  StreamSink<List<String>> get setSink => setController.sink;
  Stream<List<String>> get setStream => setController.stream;

  ColBloc(id) {
    Set<String> set = <String>{};
    eventStream.listen((event) async {
      if (event == Images.getone) {
        dataSink.add(await getPhotoStats(id));
        await getPhotoStats(id).then((value) {
          for (var i = 0; i < value.listTags.tags.length; i++) {
            if (value.listTags.tags[i].sourceTag != null) {
              set.add(
                  value.listTags.tags[i].sourceTag!.ancentryTag.typeTag.slug);
            }
          }
          List<String> listset = set.toList();
          setSink.add(listset);
        });
      }
    });
  }

  Future<OwnCol> getPhotoStats(id) async {
    var url =
        "https://api.unsplash.com/collections/$id?client_id=$key&per_page=30";

    http.Response response = await http.get(Uri.parse(url));
    return OwnCol.fromMap(jsonDecode(response.body));
  }
}

class PublicColBLoC {
  final eventController = StreamController<Images>.broadcast();
  final dataController = StreamController<List<PublicCol>>.broadcast();

  StreamSink<List<PublicCol>> get dataSink => dataController.sink;
  Stream<List<PublicCol>> get dataStream => dataController.stream;
  StreamSink<Images> get eventSink => eventController.sink;
  Stream<Images> get eventStream => eventController.stream;

  PublicColBLoC(id) {
    int y = 0;
    List<PublicCol> list = [];
    eventStream.listen((event) async {
      if (event == Images.public) {
        y++;
        await getPhotoStats(id, y).then((value) {
          list += value.listCol;
          dataSink.add(list);
        });
      }
    });
  }

  Future<ListPublicCol> getPhotoStats(id, page) async {
    var url =
        "https://api.unsplash.com/collections/$id/photos?client_id=$key&page=$page&per_page=10";

    http.Response response = await http.get(Uri.parse(url));
    return ListPublicCol.fromMap(jsonDecode(response.body));
  }
}

class RandomPhotosBLoC {
  final eventController = StreamController<Images>.broadcast();
  final dataController = StreamController<List<RandomPhotos>>.broadcast();
  final statusController = StreamController<int>.broadcast();

  StreamSink<List<RandomPhotos>> get dataSink => dataController.sink;
  Stream<List<RandomPhotos>> get dataStream => dataController.stream;
  StreamSink<Images> get eventSink => eventController.sink;
  Stream<Images> get eventStream => eventController.stream;
  StreamSink<int> get statusSink => statusController.sink;
  Stream<int> get statusStream => statusController.stream;

  RandomPhotosBLoC() {
    int y = 0;
    List<RandomPhotos> list = [];
    eventStream.listen((event) async {
      if (event == Images.random) {
        y++;
        await getPhotoStats(y).then((value) {
          list += value.list;
          dataSink.add(list);
        });
      }
    });
  }

  Future<ListRandomPhotos> getPhotoStats(page) async {
    var url =
        "https://api.unsplash.com/photos/random?client_id=$key&count=30&page=$page";

    http.Response response = await http.get(Uri.parse(url));
    statusSink.add(response.statusCode);
    return ListRandomPhotos.fromMap(jsonDecode(response.body));
  }
}
