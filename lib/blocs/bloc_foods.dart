import 'dart:async';
import 'dart:convert';

import 'package:blue_splash/blocs/bloc_random_photo.dart';
import 'package:blue_splash/models/model_foods.dart';
import 'package:http/http.dart' as http;

class BlocFoods {
  final dataController = StreamController<FoodsMain>.broadcast();
  final eventController = StreamController<ActionType>.broadcast();

  StreamSink<FoodsMain> get dataSink => dataController.sink;
  Stream<FoodsMain> get dataStream => dataController.stream;

  StreamSink<ActionType> get eventSink => eventController.sink;
  Stream<ActionType> get eventStream => eventController.stream;

  BlocFoods() {
    eventStream.listen((event) async {
      if (event == ActionType.view) {
        dataSink.add(await getPhoto());
      }
    });
  }

  Future<FoodsMain> getPhoto() async {
    var headers = {
      "Authorization": "Client-ID 3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"
    };
    http.Response response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/search/photos?query=foods&page=1&per_page=20'),
        headers: headers);

        print("Foods code : " + response.statusCode.toString());

    return FoodsMain.fromMap(jsonDecode(response.body));
  }
}
