import 'dart:async';

class ScrollBloC{
  final streamController = StreamController<double>();
  Stream<double> get pixelStream => streamController.stream;
  Sink<double> get pixelSink => streamController.sink;

  /* ScrollBloC(){
    pixelStream.listen((pixels) {
      if(pixels>0 && pixels<50){

      }
    });
  } */
}