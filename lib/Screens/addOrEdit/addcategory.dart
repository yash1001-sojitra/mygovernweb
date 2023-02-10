import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mygovernweb/Logic/provider/categorydata_provider.dart';
import 'package:provider/provider.dart';
import '../../Logic/widgets/decoration.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  File? _pickedimage;
  File? imageFile;
  File? PfdFile;
  PlatformFile? pickedFile;
  bool showLoading = false;
  Uint8List webImage = Uint8List(8);

  @override
  Widget build(BuildContext context) {
    final CategorydataProvider = Provider.of<CategoryDataProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.black12, Colors.black38],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ).createShader(bounds),
            blendMode: BlendMode.darken,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black12, BlendMode.darken),
                ),
              ),
            ),
          ),
          // Image.asset(
          //   'assets/images/back.jpg',
          //   fit: BoxFit.cover,
          //   colorBlendMode: BlendMode.darken,
          // ),
          size.width > 768
              ? Center(
                  child: SingleChildScrollView(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.7),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        //height: 400,
                        width: size.width * 0.40,
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Add Category',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Divider(
                                height: 40,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: CustomDecoration
                                    .containerCornerRadiusDecoration,
                                child: TextFormField(
                                  onChanged: (value) {
                                    CategorydataProvider.changeCategoryName(
                                        value);
                                  },
                                  decoration:
                                      CustomDecoration.textFormFieldDecoration(
                                          "Category Name"),
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
                                    Container(
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
                                    SizedBox(
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
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    showLoading = true;
                                  });
                                  progressIndicater(
                                      context, showLoading = true);
                                  if (_pickedimage == null) {
                                    String url =
                                        "https://firebasestorage.googleapis.com/v0/b/mygovern-b2fbb.appspot.com/o/url%2Fnational.png?alt=media&token=ce4e8ee7-7e20-45d2-8f9f-b9141df48222";
                                    CategorydataProvider.changeUrl(url);
                                  } else {
                                    final ref = FirebaseStorage.instance
                                        .ref()
                                        .child('url')
                                        .child(_pickedimage!.path.toString());
                                    await ref.putData(webImage);

                                    String url = await ref.getDownloadURL();
                                    CategorydataProvider.changeUrl(url);
                                  }

                                  CategorydataProvider.changetime(
                                      DateTime.now());
                                  CategorydataProvider.saveCategoryData();

                                  setState(() {
                                    showLoading = false;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                      child: Text(
                                    "Add Category",
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
                )
              : SingleChildScrollView(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white.withOpacity(0.7),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      //height: 400,
                      width: size.width * 0.40,
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Add Category',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(
                              height: 40,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: CustomDecoration
                                  .containerCornerRadiusDecoration,
                              child: TextFormField(
                                onChanged: (value) {
                                  CategorydataProvider.changeCategoryName(
                                      value);
                                },
                                decoration:
                                    CustomDecoration.textFormFieldDecoration(
                                        "Category Name"),
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
                                  Container(
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
                                  Text(_pickedimage == null
                                      ? "File not Selected"
                                      : _pickedimage!.toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    child: const Text("Select Icon"),
                                    onPressed: () {
                                      // selectFileweb();
                                      selectfilefromweb();
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  showLoading = true;
                                });
                                progressIndicater(context, showLoading = true);
                                if (_pickedimage == null) {
                                  String url =
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxhtmBqlJilp6X2q2XsYxJ9DVYb_F8x17DjIOJcHtT&s";
                                  CategorydataProvider.changeUrl(url);
                                } else {
                                  final ref = FirebaseStorage.instance
                                      .ref()
                                      .child('url')
                                      .child(_pickedimage!.path.toString());
                                  await ref.putData(webImage);

                                  String url = await ref.getDownloadURL();
                                  CategorydataProvider.changeUrl(url);
                                }

                                CategorydataProvider.changetime(DateTime.now());
                                CategorydataProvider.saveCategoryData();

                                setState(() {
                                  showLoading = false;
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                    child: Text(
                                  "Add Category",
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
        ],
      ),
    );
  }

  Future selectfilefromweb() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedimage = selected;
        });
      } else {
        print("no image has been picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
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

  Future<dynamic>? progressIndicater(BuildContext context, showLoading) {
    if (showLoading == true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    } else {
      return null;
    }
  }
}
