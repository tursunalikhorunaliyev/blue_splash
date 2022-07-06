import 'dart:async';
import 'dart:convert';
import 'package:blue_splash/models/userfromapi.dart';
import 'package:http/http.dart' as http;



enum UsersEnum { main }

class UserBlock {
  final dataStreamController = StreamController<EEEngKattaClass>.broadcast();
  final dataStreamControllerTag = StreamController<Tags>.broadcast();
  final dataStreamControllerFollower =
      StreamController<ListFollower>.broadcast();
  final dataStreamControllerPhotos =
      StreamController<ListUserPhotos>.broadcast();
  final dataStreamControllerCollect =
      StreamController<ListCollection>.broadcast();

  final eventStreamController = StreamController<UsersEnum>.broadcast();

  StreamSink<EEEngKattaClass> get dataSink => dataStreamController.sink;
  Stream<EEEngKattaClass> get dataStream => dataStreamController.stream;
  StreamSink<Tags> get dataSinkTag => dataStreamControllerTag.sink;
  Stream<Tags> get dataStreamTag => dataStreamControllerTag.stream;
  StreamSink<ListFollower> get dataSinkFollower =>
      dataStreamControllerFollower.sink;
  Stream<ListFollower> get dataStreamFollower =>
      dataStreamControllerFollower.stream;
  StreamSink<ListCollection> get dataSinkCollect =>
      dataStreamControllerCollect.sink;
  Stream<ListCollection> get dataStreamCollect =>
      dataStreamControllerCollect.stream;
  StreamSink<ListUserPhotos> get dataSinkPhotos =>
      dataStreamControllerPhotos.sink;
  Stream<ListUserPhotos> get dataStreamPhotos =>
      dataStreamControllerPhotos.stream;

  StreamSink<UsersEnum> get eventSink => eventStreamController.sink;
  Stream<UsersEnum> get eventStream => eventStreamController.stream;

  final streamControllerTags = StreamController<List<String>>.broadcast();
  Stream<List<String>> get streamUpSource => streamControllerTags.stream;
  Sink<List<String>> get sinkUpSource => streamControllerTags.sink;

  UserBlock(id) {
    Set<String> source = <String>{};
    eventStream.listen((event) async {
      if (event == UsersEnum.main) {
        dataSink.add(await mainFuture(id));
        dataSinkCollect.add(await userCollection(id));
        dataSinkPhotos.add(await userPhotos(id));
        dataSinkFollower.add(await userFollower(id));
        await mainFuture(id).then((value) {
          for (int i = 0; i < value.tags.custom.length; i++) {
            if (value.tags.custom[i].source != null) {
              print(i);
              source.add(value.tags.custom[i].source!.ancestry!.type!.slug);
              if (value.tags.custom[i].source!.ancestry!.category != null &&
                  value.tags.custom[i].source!.ancestry!.subCategory != null) {
                source.add(
                    value.tags.custom[i].source!.ancestry!.category!.slug!);
                source.add(
                    value.tags.custom[i].source!.ancestry!.subCategory!.slug!);
              } else if (value.tags.custom[i].source!.ancestry!.category !=
                      null &&
                  value.tags.custom[i].source!.ancestry!.subCategory == null) {
                source.add(
                    value.tags.custom[i].source!.ancestry!.category!.slug!);
              }
            }
          }
          for (int i = 0; i < value.tags.aggregated.length; i++) {
            if (value.tags.aggregated[i].source != null) {
              print(i);
              source.add(value.tags.aggregated[i].source!.ancestry!.type!.slug);
              if (value.tags.aggregated[i].source!.ancestry!.category != null &&
                  value.tags.aggregated[i].source!.ancestry!.subCategory !=
                      null) {
                source.add(
                    value.tags.aggregated[i].source!.ancestry!.category!.slug!);
                source.add(value
                    .tags.aggregated[i].source!.ancestry!.subCategory!.slug!);
              } else if (value.tags.aggregated[i].source!.ancestry!.category !=
                      null &&
                  value.tags.aggregated[i].source!.ancestry!.subCategory ==
                      null) {
                source.add(
                    value.tags.aggregated[i].source!.ancestry!.category!.slug!);
              }
            }
          }
          List<String> listSet = source.toList();
          sinkUpSource.add(listSet);
        });
        // dataSinkTag.add(await usertag(id));
      }
    });
  }

  Future<EEEngKattaClass> mainFuture(id) async {
    var url =
        'https://api.unsplash.com/users/$id?client_id=3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk';

    http.Response response = await http.get(Uri.parse(url));

    return EEEngKattaClass.fromMap(jsonDecode(response.body));
  }

  Future<ListCollection> userCollection(id) async {
    var url =
        'https://api.unsplash.com/users/$id/collections?client_id=9rrTgoEs48ptJewwzSpMYMDe0gP6r5OnNzDTa2MRDgc';

    http.Response response = await http.get(Uri.parse(url));

    return ListCollection.fromMap(jsonDecode(response.body));
  }

  Future<ListUserPhotos> userPhotos(id) async {
    var url =
        'https://api.unsplash.com/users/$id/photos?client_id=9rrTgoEs48ptJewwzSpMYMDe0gP6r5OnNzDTa2MRDgc';

    http.Response response = await http.get(Uri.parse(url));

    return ListUserPhotos.fromMap(jsonDecode(response.body));
  }

  Future<ListFollower> userFollower(id) async {
    var url =
        'https://api.unsplash.com/users/$id/followers?client_id=9rrTgoEs48ptJewwzSpMYMDe0gP6r5OnNzDTa2MRDgc';

    http.Response response = await http.get(Uri.parse(url));

    return ListFollower.fromMap(jsonDecode(response.body));
  }
}
