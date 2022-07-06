import 'dart:async';
import 'dart:convert';

import 'package:blue_splash/models/category_photo_model.dart';
import 'package:http/http.dart' as http;

enum UnsplashCategoryAction {
  show,
  foods,
  drinks,
  pahlava,
  fruits,
}

class BlocCategory {
  final dataController = StreamController<List<CategoryesModel>>.broadcast();
  final eventController = StreamController<UnsplashCategoryAction>.broadcast();

  StreamSink<List<CategoryesModel>> get dataSink => dataController.sink;
  Stream<List<CategoryesModel>> get dataStream => dataController.stream;

  StreamSink<UnsplashCategoryAction> get eventSink => eventController.sink;
  Stream<UnsplashCategoryAction> get eventStream => eventController.stream;

  BlocCategory() {
    int index = 0;

    List<CategoryesModel> list = [];

    eventStream.listen((event) async {
      if (event == UnsplashCategoryAction.drinks) {
        index++;
       
        await getCategoryPhotos("drinks", index).then((value) {
          list += value.list;

          dataSink.add(list);
        });
        
      }

      if (event == UnsplashCategoryAction.foods) {
        index++;
    
        await getCategoryPhotos("foods", index).then((value) {
          list += value.list;

          dataSink.add(list);
        });

        
      }
      if (event == UnsplashCategoryAction.fruits) {
        index++;

        await getCategoryPhotos("fruits", index).then((value) {
          list += value.list;

          dataSink.add(list);
        });

       
      }
      if (event == UnsplashCategoryAction.pahlava) {
        index++;

        await getCategoryPhotos("cakes", index).then((value) {
          list += value.list;

          dataSink.add(list);
        });

       
      }
      if (event == UnsplashCategoryAction.show) {
        index++;
    
        await getCategoryPhotos("error", index).then((value) {
          list += value.list;

          dataSink.add(list);
        });

        return;
      }
    });
  }

  Future<CtegoryMain> getCategoryPhotos(String category, int index) async {
    print(category);
    var headers = {
      "Authorization": "Client-ID 3Tp20rmhXOQ5shcN8lc1eh9YgTh3cTsAjqc8kPktvCk"
    };
    http.Response response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/search/photos?query=$category&page=1&per_page=20'),
        headers: headers);

    print("Category " + response.statusCode.toString());

    return CtegoryMain.fromMap(jsonDecode(response.body));
  }
}
