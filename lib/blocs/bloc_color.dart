import 'dart:async';

class BlocColor {
  final dataController = StreamController<int>.broadcast();
  StreamSink<int> get dataSink => dataController.sink;
  Stream<int> get dataStream => dataController.stream;
}
