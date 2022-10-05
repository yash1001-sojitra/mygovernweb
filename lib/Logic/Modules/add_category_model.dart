class CategoryData {
  String id;
  String category;
  late String url;
  DateTime time;

  CategoryData({
    required this.id,
    required this.category,
    required this.url,
    required this.time,
  });

  Map<String, dynamic> createMap() {
    return {
      'Id': id,
      'Category': category,
      'url': url,
      'time': time,
    };
  }

  CategoryData.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['Id'],
        category = firestoreMap['Category'],
        url = firestoreMap['url'],
        time = firestoreMap['time'].toDate();

  toList() {}
}
