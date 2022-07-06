import 'dart:async';
import 'dart:convert';
import 'package:blue_splash/blocs/bloc_random_photo.dart';
import 'package:blue_splash/models/model_latest.dart';
import 'package:http/http.dart' as http;

class BlocLatest {
  final dataController = StreamController<LatestMain>.broadcast();
  final eventController = StreamController<ActionType>.broadcast();

  StreamSink<LatestMain> get dataSink => dataController.sink;
  Stream<LatestMain> get dataStream => dataController.stream;

  StreamSink<ActionType> get eventSink => eventController.sink;
  Stream<ActionType> get eventStream => eventController.stream;

  BlocLatest() {
    eventStream.listen((event) async {
      if (event == ActionType.view) {
        dataSink.add(await getPhoto());
      }
    });
  }

  Future<LatestMain> getPhoto() async {
    var headers = {
      "Authorization": "Client-ID 3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"
    };
    http.Response response = await http.get(
        Uri.parse('https://api.unsplash.com/photos?page=1&per_page=20'),
        headers: headers);
   

    return LatestMain.fromMap(jsonDecode(response.body));
  }
}
