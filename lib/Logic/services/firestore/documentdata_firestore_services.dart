// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mygovernweb/Logic/Modules/add_documentdata_model.dart';

class DocumentDataFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDocumentData(AddDocData docData) {
    return _db
        .collection('DocumentDetails')
        .doc(docData.id)
        .set(docData.createMap());
  }

  Future<void> removeCategory(String DocId) {
    return _db.collection('DocumentDetails').doc(DocId).delete();
  }
}
