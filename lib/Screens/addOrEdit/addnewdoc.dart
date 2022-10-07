import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  File? _pickedimage;
  File? imageFile;
  File? PfdFile;
  PlatformFile? pickedFile;
  bool showLoading = false;
  Uint8List webImage = Uint8List(8);
  CategoryData? _selectedCategory;
  String? _selectedCertificate;
  bool _isAdd = false;
  Map<String, dynamic> data = {};
  List<String> docSteps = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder<List<CategoryData>>(
          stream: CategoryDataFirestoreService().getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/back.jpg',
                  fit: BoxFit.cover,
                ),
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
                              width: size.width * 0.40,
                              child: Form(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: CustomDecoration
                                                .containerCornerRadiusDecoration,
                                            child: DropdownButton<String>(
                                              onChanged: (val) {
                                                setState(() {
                                                  _selectedCategory = snapshot
                                                      .data
                                                      ?.firstWhere((element) =>
                                                          element.category ==
                                                          val) as CategoryData;
                                                });
                                              },
                                              value:
                                                  _selectedCategory?.category,
                                              items: snapshot.data
                                                  ?.map((e) => e)
                                                  .toSet()
                                                  .map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.category,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
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
                                          FutureBuilder<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>(
                                              future: FirebaseFirestore.instance
                                                  .collection('Category')
                                                  .doc(_selectedCategory?.id)
                                                  .collection('Documents')
                                                  .get(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration: CustomDecoration
                                                            .containerCornerRadiusDecoration,
                                                        child: _isAdd
                                                            ? TextFormField(
                                                                decoration: CustomDecoration
                                                                    .textFormFieldDecoration(
                                                                        "Certificate Name"),
                                                              )
                                                            : DropdownButton<
                                                                String>(
                                                                value:
                                                                    _selectedCertificate,
                                                                onChanged:
                                                                    (val) {
                                                                  setState(() =>
                                                                      _selectedCertificate =
                                                                          val);
                                                                },
                                                                items: snapshot
                                                                    .data!.docs
                                                                    .toSet()
                                                                    .map((e) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: e.id,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              15),
                                                                      child: Text(
                                                                          e.id),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                                hint: const Text(
                                                                    'Choose Certificate'),
                                                                iconSize: 40,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                underline:
                                                                    Container(),
                                                                isExpanded:
                                                                    true,
                                                                menuMaxHeight:
                                                                    500,
                                                              ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState((() =>
                                                              _isAdd = true));
                                                        },
                                                        child: Container(
                                                          height: 60,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Flexible(
                                                                child: Text(
                                                              'Add',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    if (snapshot.data!.size > 0)
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState((() =>
                                                                _isAdd =
                                                                    false));
                                                          },
                                                          child: Container(
                                                            height: 60,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: snapshot
                                                                          .data ==
                                                                      null
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .blueAccent,
                                                            ),
                                                            child:
                                                                const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Flexible(
                                                                  child: Text(
                                                                'Choose',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              }),
                                        ],
                                      );
                                    }),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: CustomDecoration
                                          .containerCornerRadiusDecoration,
                                      child: TextFormField(
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
                                                      : Image.file(
                                                          _pickedimage!)),
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
                                    const RequiredDocument(),
                                    const SizedBox(height: 10),
                                    Steps(docSteps),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: CustomDecoration
                                          .containerCornerRadiusDecoration,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.asset(
                                                      "assets/images/addpdf.png")),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text(pickedFile == null
                                                  ? "File not Selected"
                                                  : pickedFile!.name),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              TextButton(
                                                child: const Text(
                                                    "Select Document"),
                                                onPressed: () {
                                                  selectFile(FileType.any);
                                                },
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: const [
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "or",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: CustomDecoration
                                                .containerCornerRadiusDecoration
                                                .copyWith(
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                            child: TextFormField(
                                              decoration: CustomDecoration
                                                  .textFormFieldDecoration(
                                                      "Document Url"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        progressIndicater(context, true);
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
                      )
                    : SingleChildScrollView(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white.withOpacity(0.7),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: size.width * 0.40,
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
                                  StatefulBuilder(builder: (context, setState) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: CustomDecoration
                                          .containerCornerRadiusDecoration,
                                      child: DropdownButton<String>(
                                        onChanged: (val) {
                                          setState(() {
                                            _selectedCategory =
                                                val as CategoryData;
                                          });
                                        },
                                        value: _selectedCategory?.category,
                                        items: snapshot.data
                                            ?.map((e) => e)
                                            .toSet()
                                            .toList()
                                            .map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e.category,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(e.category),
                                            ),
                                          );
                                        }).toList(),
                                        hint: const Text('Category'),
                                        iconSize: 40,
                                        borderRadius: BorderRadius.circular(10),
                                        underline: Container(),
                                        isExpanded: true,
                                        menuMaxHeight: 500,
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 10),
                                  FutureBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      future: _selectedCategory != null
                                          ? FirebaseFirestore.instance
                                              .collection('Category')
                                              .doc(_selectedCategory?.id)
                                              .collection('Documents')
                                              .get()
                                          : null,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: CustomDecoration
                                                      .containerCornerRadiusDecoration,
                                                  child: _isAdd
                                                      ? TextFormField(
                                                          decoration: CustomDecoration
                                                              .textFormFieldDecoration(
                                                                  "Certificate Name"),
                                                        )
                                                      : DropdownButton<String>(
                                                          value:
                                                              _selectedCertificate,
                                                          onChanged: (val) {
                                                            setState(() =>
                                                                _selectedCertificate =
                                                                    val);
                                                          },
                                                          items: <String>[
                                                            'A',
                                                            'B',
                                                            'C'
                                                          ].map((e) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: e,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                child: Text(e),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          hint: const Text(
                                                              'Choose Certificate'),
                                                          iconSize: 40,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          underline:
                                                              Container(),
                                                          isExpanded: true,
                                                          menuMaxHeight: 500,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(
                                                        (() => _isAdd = true));
                                                  },
                                                  child: Container(
                                                    height: 60,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.purple,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Flexible(
                                                          child: Text(
                                                        'Add',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(
                                                        (() => _isAdd = false));
                                                  },
                                                  child: Container(
                                                    height: 60,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.purple,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Flexible(
                                                          child: Text(
                                                        'Choose',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                      }),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: CustomDecoration
                                        .containerCornerRadiusDecoration,
                                    child: TextFormField(
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
                                                    : Image.file(
                                                        _pickedimage!)),
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
                                  const RequiredDocument(),
                                  const SizedBox(height: 10),
                                  Steps(docSteps),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: CustomDecoration
                                        .containerCornerRadiusDecoration,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                height: 50,
                                                width: 50,
                                                child: Image.asset(
                                                    "assets/images/addpdf.png")),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(pickedFile == null
                                                ? "File not Selected"
                                                : pickedFile!.name),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            TextButton(
                                              child:
                                                  const Text("Select Document"),
                                              onPressed: () {
                                                selectFile(FileType.any);
                                              },
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: const [
                                            Expanded(
                                              child: Divider(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "or",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Image.asset(
                                                "assets/images/addpdf.png")),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_selectedCategory != null ||
                                          _selectedCertificate != null) {
                                        progressIndicater(context, true);
                                        FirebaseFirestore.instance
                                            .collection('Category')
                                            .doc(_selectedCategory?.id)
                                            .collection('Documents')
                                            .doc(_selectedCertificate)
                                            .set({
                                          'Id': const Uuid().v4(),
                                          'document': _selectedCertificate,
                                          'steps': docSteps,
                                          'requiredDoc': 'requ doc',
                                        });

                                        progressIndicater(context, false);
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
                      )
              ],
            );
          }),
    );
  }

  Future selectFile(FileType fileType) async {
    final result = await FilePicker.platform.pickFiles(type: fileType);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first.bytes as PlatformFile?;

      if (pickedFile != null) {
        PfdFile = File(pickedFile!.name.toString());
      }
    });
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

  Future<dynamic>? progressIndicater(BuildContext context, showLoading) {
    if (showLoading == true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
                child: Lottie.asset("assets/animations/lodingtrans.json",
                    height: 50, width: 50)
                // CircularProgressIndicator(),
                );
          });
    } else {
      return null;
    }
  }
}
