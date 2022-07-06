import 'dart:async';
import 'dart:convert';

import 'package:blue_splash/blocs/bloc_random_photo.dart';
import 'package:blue_splash/models/model_search_screen.dart';
import 'package:http/http.dart' as http;

class BlocSearchScreen {
  String query = "";
  String orientation = "";
  String color = "";
  String sortBy = "";
  String contentFilter = "";

  final dataController = StreamController<List<ModelSearchScreen>>.broadcast();
  final eventController = StreamController<ActionType>.broadcast();

  StreamSink<List<ModelSearchScreen>> get dataSink => dataController.sink;
  Stream<List<ModelSearchScreen>> get dataStream => dataController.stream;

  StreamSink<ActionType> get eventSink => eventController.sink;
  Stream<ActionType> get eventStream => eventController.stream;

  BlocSearchScreen() {
    int a = 0;
    List<ModelSearchScreen> colllections = [];

    eventStream.listen((event) async {
      if (event == ActionType.newSearch) {
        colllections.clear();

        if (query.isNotEmpty) {
          await getPhoto(query, orientation, color, sortBy, contentFilter, 1)
              .then((value) {
            colllections += value.list;
            dataSink.add(colllections);
          });
        }
      }
      if (event == ActionType.update) {
        a++;
        if (query.isNotEmpty) {
          await getPhoto(query, orientation, color, sortBy, contentFilter, a)
              .then((value) {
            colllections += value.list;
            dataSink.add(colllections);
          });
        }
      }
      if (event == ActionType.updateUnColor) {
        a++;
        if (query.isNotEmpty) {
          await getPhotoUnColor(query, orientation, sortBy, contentFilter, a)
              .then((value) {
            colllections += value.list;
            dataSink.add(colllections);
          });
        }
      }
      if (event == ActionType.newSearchUnColor) {
        colllections.clear();
        if (query.isNotEmpty) {
          await getPhotoUnColor(query, orientation, sortBy, contentFilter, 1)
              .then((value) {
            colllections += value.list;
            dataSink.add(colllections);
          });
          ;
        }
      }
    });
  }

  fullParams(String query, String orientation, String color, String sortBy,
      String contentFilter) {
    this.query = query;
    this.orientation = orientation;
    this.color = color;
    this.sortBy = sortBy;
    this.contentFilter = contentFilter;
  }

  params(
      String query, String orientation, String sortBy, String contentFilter) {
    this.query = query;
    this.orientation = orientation;
    this.sortBy = sortBy;
    this.contentFilter = contentFilter;
  }

  Future<ModelSearchScreenMain> getPhoto(String query, String orientation,
      String color, String sortBy, String contentFilter, int page) async {
    var headers = {
      "Authorization": "Client-ID 3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"
    };
    http.Response response = await http.get(
        Uri.parse(
            "https://api.unsplash.com/search/photos?query=$query&page=$page&per_page=30&orientation=$orientation&content_filter=$contentFilter&order_by=$sortBy&color=$color"),
        headers: headers);

    print(response.statusCode.toString() + " status code get Photo");

    return ModelSearchScreenMain.fromMap(jsonDecode(response.body));
  }

  Future<ModelSearchScreenMain> getPhotoUnColor(String query,
      String orientation, String sortBy, String contentFilter, int page) async {
    var headers = {
      "Authorization": "Client-ID 3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"
    };
    http.Response response = await http.get(
        Uri.parse(
            "https://api.unsplash.com/search/photos?query=$query&page=$page&per_page=30&orientation=$orientation&content_filter=$contentFilter&order_by=$sortBy"),
        headers: headers);
    print(orientation + " yuyuyu");
    print(response.statusCode.toString() + " status code get Photo uncolor");

    return ModelSearchScreenMain.fromMap(jsonDecode(response.body));
  }
}
