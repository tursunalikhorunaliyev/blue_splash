import 'dart:async';
import 'dart:convert';
import 'package:blue_splash/models/tags_photofromapi.dart';
import 'package:http/http.dart' as http;



enum Anim { inc, dec, tag }

class AnimationBlock {
  final eventController = StreamController<Anim>.broadcast();
  final dataController = StreamController<double>.broadcast();

  StreamSink<double> get dataSink => dataController.sink;
  Stream<double> get dataStream => dataController.stream;
  StreamSink<Anim> get eventSink => eventController.sink;
  Stream<Anim> get eventStream => eventController.stream;

  AnimationBlock() {
    eventStream.listen((event) async {
      if (event == Anim.inc) {
        dataSink.add(59);
      } else if (event == Anim.dec) {
        dataSink.add(0);
      }
    });
  }
}

class BlcokForTagPhoto {
  final eventController = StreamController<Anim>.broadcast();
  final dataController = StreamController<List<TagPhotoKatta>>.broadcast();
  final dataControllerInt = StreamController<int>.broadcast();

  StreamSink<List<TagPhotoKatta>> get dataSink => dataController.sink;
  Stream<List<TagPhotoKatta>> get dataStream => dataController.stream;
  StreamSink<int> get dataSinkInt => dataControllerInt.sink;
  Stream<int> get dataStreamInt => dataControllerInt.stream;
  StreamSink<Anim> get eventSinktag => eventController.sink;
  Stream<Anim> get eventStreamtag => eventController.stream;

  BlcokForTagPhoto(id) {
    int page = 0;
    List<TagPhotoKatta> list = [];
    eventStreamtag.listen((event) async {
      if (event == Anim.tag) {
        page++;

        mainFuture(id, page).then((value) {
          list += value.list;

          dataSink.add(list);
        });
      }
    });
  }
  Future<TagList> mainFuture(id, page) async {
    var url =
        'https://api.unsplash.com/topics/$id/photos?client_id=LadkGfS6e_rzmaghTUdTal-0cFcIcXtdJCIdlaiUhSU&page=$page&per_page=20';

    http.Response response = await http.get(Uri.parse(url));
    dataSinkInt.add(response.statusCode);

    return TagList.fromMap(jsonDecode(response.body));
  }
}
