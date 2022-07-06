import 'dart:async';

class ConnectionChecker {
  final dataController = StreamController<List<bool>>.broadcast();

  StreamSink<List<bool>> get dataSink => dataController.sink;
  Stream<List<bool>> get dataStream => dataController.stream;



  }


