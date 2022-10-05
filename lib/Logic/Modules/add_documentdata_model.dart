class AddDocData {
  String id;
  String category;
  String docCategory;
  List requireddoc;
  List stepofdoc;
  late String url;
  DateTime time;

  AddDocData({
    required this.id,
    required this.category,
    required this.docCategory,
    required this.requireddoc,
    required this.stepofdoc,
    required this.url,
    required this.time,
  });

  Map<String, dynamic> createMap() {
    return {
      'Id': id,
      'Category': category,
      'DocName': docCategory,
      'RequiredDoc': requireddoc,
      'StepofDoc': stepofdoc,
      'url': url,
      'time': time,
    };
  }

  AddDocData.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['Id'],
        category = firestoreMap['Category'],
        docCategory = firestoreMap['DocName'],
        requireddoc = firestoreMap['RequiredDoc'],
        stepofdoc = firestoreMap['StepofDoc'],
        url = firestoreMap['url'],
        time = firestoreMap['time'].toDate();

  toList() {}
}
