import 'dart:async';
import 'dart:convert';

import 'package:blue_splash/models/model_random_photo.dart';
import 'package:http/http.dart' as http;

enum ActionType {
  view,
  update,
  newSearch,
  updateUnColor,
  newSearchUnColor
}

class BlocRandomPhoto {
  final dataController = StreamController<RandomMain>.broadcast();
  final eventController = StreamController<ActionType>.broadcast();

  StreamSink<RandomMain> get dataSink => dataController.sink;
  Stream<RandomMain> get dataStream => dataController.stream;

  StreamSink<ActionType> get eventSink => eventController.sink;
  Stream<ActionType> get eventStream => eventController.stream;

  BlocRandomPhoto() {
    eventStream.listen((event) async {
      if (event == ActionType.view) {
        dataSink.add(await getPhoto());
      }
    });
  }

  Future<RandomMain> getPhoto() async {
    var headers = {
      "Authorization": "Client-ID 3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"
    };
    http.Response response = await http.get(
        Uri.parse('https://api.unsplash.com/photos/random?count=20'),
        headers: headers);
     
        print(response.statusCode.toString() + "Random code");

    return RandomMain.fromMap(jsonDecode(response.body));
  }
}
