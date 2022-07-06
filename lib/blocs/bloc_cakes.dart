import 'dart:async';
import 'dart:convert';

import 'package:blue_splash/models/model_cakes.dart';
import 'package:http/http.dart' as http;

import 'bloc_random_photo.dart';

class BlocCakes {
  final dataController = StreamController<CakesMain>.broadcast();
  final eventController = StreamController<ActionType>.broadcast();

  StreamSink<CakesMain> get dataSink => dataController.sink;
  Stream<CakesMain> get dataStream => dataController.stream;

  StreamSink<ActionType> get eventSink => eventController.sink;
  Stream<ActionType> get eventStream => eventController.stream;

  BlocCakes() {
    eventStream.listen((event) async {
      if (event == ActionType.view) {
        dataSink.add(await getPhoto());
      }
    });
  }

  Future<CakesMain> getPhoto() async {
    var headers = {
      "Authorization": "Client-ID 3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"
    };
    http.Response response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/search/photos?query=cakes&page=1&per_page=20'),
        headers: headers);

    return CakesMain.fromMap(jsonDecode(response.body));
  }
}
