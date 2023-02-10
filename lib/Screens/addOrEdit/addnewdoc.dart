import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mygovernweb/Screens/addOrEdit/widgets/requireddoc.dart';
import 'package:mygovernweb/Screens/addOrEdit/widgets/steps.dart';
import 'package:uuid/uuid.dart';

import '../../Logic/Modules/add_category_model.dart';
import '../../Logic/services/firestore/category_firestore_services.dart';
import '../../Logic/widgets/decoration.dart';

class AddnewDoc extends StatefulWidget {
  const AddnewDoc({super.key});

  @override
  State<AddnewDoc> createState() => _AddnewDocState();
}

class _AddnewDocState extends State<AddnewDoc> {
  final _controller = TextEditingController();
  File? _pickedimage;

  Uint8List webImage = Uint8List(8);
  CategoryData? _selectedCategory;
  String? _selectedCertificate;
  List<String> docSteps = [];
  List<String> docRequired = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder<List<CategoryData>>(
          stream: CategoryDataFirestoreService().getCategories(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                /*   Image.asset(
                  'assets/images/image1.jpg',
                  fit: BoxFit.cover,
                ),
 */
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    /*  Color(0xffADA996),
                    Color(0xffF2F2F2),
                    Color(0xffDBDBDB),
                    Color(0xffEAEAEA) */
                  ])),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white.withOpacity(1),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(15),
                          width: size.width > 768
                              ? size.width * 0.40
                              : size.width * 0.90,
                          child: Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Add Document',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  height: 40,
                                ),
                                StatefulBuilder(builder: (cntx, setState) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: CustomDecoration
                                            .containerCornerRadiusDecoration,
                                        child: DropdownButton<String>(
                                          onChanged: (val) {
                                            setState(() {
                                              _selectedCategory = snapshot.data
                                                  ?.firstWhere((element) =>
                                                      element.category ==
                                                      val) as CategoryData;
                                            });
                                          },
                                          value: _selectedCategory?.category,
                                          items: snapshot.data
                                              ?.map((e) => e)
                                              .toSet()
                                              .map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.category,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text(e.category),
                                              ),
                                            );
                                          }).toList(),
                                          hint: const Text('Category'),
                                          iconSize: 40,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          underline: Container(),
                                          isExpanded: true,
                                          menuMaxHeight: 500,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: CustomDecoration
                                      .containerCornerRadiusDecoration,
                                  child: TextFormField(
                                    controller: _controller,
                                    decoration: CustomDecoration
                                        .textFormFieldDecoration(
                                            "Document Name"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: CustomDecoration
                                      .containerCornerRadiusDecoration,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: _pickedimage == null
                                              ? Image.asset(
                                                  "assets/images/add-image.png")
                                              : kIsWeb
                                                  ? Image.memory(webImage)
                                                  : Image.file(_pickedimage!)),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Flexible(
                                        child: Text(
                                          _pickedimage == null
                                              ? "File not Selected"
                                              : _pickedimage!.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      TextButton(
                                        child: const Text("Select Icon"),
                                        onPressed: () {
                                          selectfilefromweb();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RequiredDocument(docRequired),
                                const SizedBox(height: 10),
                                Steps(docSteps),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () async {
                                    final data = await FirebaseFirestore
                                        .instance
                                        .collection('Category')
                                        .doc(_selectedCategory?.id)
                                        .collection('Documents')
                                        .get();
                                    final ids =
                                        data.docs.map((e) => e.id).toList();
                                    try {
                                      if (_selectedCategory != null ||
                                          _controller.text.isNotEmpty ||
                                          docSteps.isNotEmpty ||
                                          docRequired.isNotEmpty) {
                                        if (ids.contains(_controller.text)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Entered document is already present!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          );
                                          return;
                                        }
                                        progressIndicater(context, true);
                                        final ref = FirebaseStorage.instance
                                            .ref()
                                            .child('url')
                                            .child(_controller.text);
                                        await ref.putData(webImage);
                                        String url = await ref.getDownloadURL();
                                        await FirebaseFirestore.instance
                                            .collection('Category')
                                            .doc(_selectedCategory?.id)
                                            .collection('Documents')
                                            .doc(_controller.text)
                                            .set({
                                          'Id': const Uuid().v4(),
                                          'document': _controller.text,
                                          'steps': docSteps,
                                          'requiredDoc': docRequired,
                                          'iconUrl': url,
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Document Added Successfully!',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                        Navigator.pop(context);
                                        Get.toNamed('/home');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          'Fill all the details!',
                                          textAlign: TextAlign.center,
                                        )));
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                        child: Text(
                                      "Upload Details",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Future selectfilefromweb() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedimage = selected;
        });
      } else {
        print("no image has been picked");
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedimage = File(image.name);
        });
      } else {
        print("no image has been picked");
      }
    } else {
      print('something went wrong');
    }
  }

  Future progressIndicater(BuildContext context, showLoading) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
              child: Lottie.asset("assets/animations/lodingtrans.json",
                  height: 50, width: 50)
              // CircularProgressIndicator(),
              );
        });
  }
}
