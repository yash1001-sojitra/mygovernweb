// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mygovernweb/Logic/Modules/add_category_model.dart';
import 'package:mygovernweb/Logic/services/firestore/category_firestore_services.dart';
import 'package:uuid/uuid.dart';

class CategoryDataProvider with ChangeNotifier {
  final service = CategoryDataFirestoreService();
  late String _categoryname;
  late DateTime _time;
  late String _url;
  var uuid = const Uuid();

  // getter
  String get getcategoryName => _categoryname;
  DateTime get getTime => _time;
  String get getUrl => _url;

  //Setters:
  void changeCategoryName(String value) {
    _categoryname = value;
    notifyListeners();
  }

  void changetime(DateTime time) {
    _time = time;
    notifyListeners();
  }

  void changeUrl(String url) {
    _url = url;
    notifyListeners();
  }

  void saveCategoryData() {
    var newcategoryData = CategoryData(
        id: uuid.v4(), category: _categoryname, time: getTime, url: _url);
    service.saveCategoryData(newcategoryData);
  }

  void deleteAnimalData(AnimalId) {
    service.removeCategory(AnimalId);
  }
}
