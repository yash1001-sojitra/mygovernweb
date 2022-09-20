import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PaperGenerateController extends GetxController {
  final testPaperName = ''.obs;
  final className = ''.obs;
  final subjectName = ''.obs;
  final time = ''.obs;
  final instruction = ''.obs;
  

  getBlueprint({className,subjectName}) async{
      await FirebaseFirestore.instance
      .collection('')
      .where('Class',isEqualTo: className)
      .where('SubjectName',isEqualTo: subjectName)
      .get().then((value) {
        value.docs.forEach((element) {
          print(element.data());
        }); 
      });
  }
}