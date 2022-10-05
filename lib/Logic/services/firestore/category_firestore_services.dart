// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mygovernweb/Logic/Modules/add_category_model.dart';

class CategoryDataFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveCategoryData(CategoryData categoryData) {
    return _db
        .collection('Category')
        .doc(categoryData.id)
        .set(categoryData.createMap());
  }

  Future<void> removeCategory(String categoryDocId) {
    return _db.collection('Category').doc(categoryDocId).delete();
  }
}
