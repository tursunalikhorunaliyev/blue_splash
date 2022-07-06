import 'dart:async';

class BlocOrientation {
   final dataController = StreamController<int>.broadcast();
  StreamSink<int> get dataSink => dataController.sink;
  Stream<int> get dataStream => dataController.stream;
}