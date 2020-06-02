import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:learn_5_great_places_app/models/place.dart';

import './../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map(
          (i) => Place(
            id: i['id'],
            title: i['title'],
            location: null,
            image: File(i['image']),
          ),
        )
        .toList();
        notifyListeners();
  }
}
