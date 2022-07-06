import 'dart:async';
import 'dart:convert';


import 'package:blue_splash/blocs/bloc_random_photo.dart';
import 'package:blue_splash/models/model_drinks.dart';
import 'package:http/http.dart' as http;

class BlocDrinks {
  final dataController = StreamController<DrinksMain>.broadcast();
  final eventController = StreamController<ActionType>.broadcast();

  StreamSink<DrinksMain> get dataSink => dataController.sink;
  Stream<DrinksMain> get dataStream => dataController.stream;

  StreamSink<ActionType> get eventSink => eventController.sink;
  Stream<ActionType> get eventStream => eventController.stream;

  BlocDrinks() {
    eventStream.listen((event) async {
      if (event == ActionType.view) {
        dataSink.add(await getPhoto());
      }
    });
  }

  Future<DrinksMain> getPhoto() async {
    var headers = {
      "Authorization": "Client-ID 3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"
    };
    http.Response response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/search/photos?query=drinks&page=1&per_page=20'),
        headers: headers);

    return DrinksMain.fromMap(jsonDecode(response.body));
  }
}
