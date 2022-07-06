import 'dart:async';

class BlocQuality {
  final dataController = StreamController<int>.broadcast();
  StreamSink<int> get dataSink => dataController.sink;
  Stream<int> get dataStream => dataController.stream;
}
