import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddNewDocController extends GetxController {
  final classValue = "".obs;
  final subjectValue = "".obs;
  final chapterNumber = "".obs;
  final chapterName = "".obs;
  final isLoading = false.obs;
  final isSubjectVisible = false.obs;
  final isChapterName = false.obs;
  final isChapterNumber = false.obs;
  List<dynamic> subjectList = [""].obs;

  final viewChapterClassValue = "".obs;
  final viewChapterSubjectValue = "".obs;
  List<dynamic> viewChapterSubjectList = [""].obs;

  final viewChapterSubjectVisible = false.obs;

  final chaptersList = {}.obs;
  final chapterLoading = false.obs;

  List<String> categoryList = [
    "",
    "નાગરિક સેવાઓ",
    "રેશન કાર્ડ",
    "આવક(Revenue)/ જમીન",
    "મેજિસ્ટ્રિયલ",
    "અન્ય"
  ];

  getSubjectList(String className, bool fromViewChapter) async {
    isSubjectVisible.value = false;
    isChapterName.value = false;
    isChapterNumber.value = false;
    if (fromViewChapter) {
      viewChapterSubjectVisible.value = false;
    }

    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("question_bank")
        .doc(className)
        .get()
        .then((value) {
      subjectList = value.data()!['subject'];
      subjectList.insert(0, "");
      if (fromViewChapter) {
        viewChapterSubjectList = value.data()!['subject'];
        viewChapterSubjectList.insert(0, "");
      }
    });

    isLoading.toggle();
    isSubjectVisible.value = true;
    isChapterName.value = true;
    isChapterNumber.value = true;
    if (fromViewChapter) {
      viewChapterSubjectVisible.value = true;
    }
  }

  getChapterName(String className, String subjectName) async {
    chapterLoading.toggle();
    chaptersList.value = {};
    await FirebaseFirestore.instance
        .collection("question_bank")
        .doc(className)
        .get()
        .then((val) {
      if (val.data()![subjectName] != null) {
        chaptersList['Chapter No.'] = 'Chapter Name';
        val.data()![subjectName].forEach((key, value) {
          chaptersList[key] = value['chapterName'];
        });
        print(chaptersList.value);
      }
    });
    chapterLoading.toggle();
  }
}
