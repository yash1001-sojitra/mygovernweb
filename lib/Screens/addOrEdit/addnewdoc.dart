import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mygovernweb/Screens/addOrEdit/widgets/requireddoc.dart';
import 'package:mygovernweb/Screens/addOrEdit/widgets/steps.dart';

import '../../Logic/widgets/decoration.dart';

class AddnewDoc extends StatefulWidget {
  const AddnewDoc({super.key});

  @override
  State<AddnewDoc> createState() => _AddnewDocState();
}

class _AddnewDocState extends State<AddnewDoc> {
  late File imageFile;
  PlatformFile? pickedFile;
  bool showLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
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
                        //height: 400,
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
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: CustomDecoration
                                    .containerCornerRadiusDecoration,
                                child: DropdownButton<String>(
                                  onChanged: (val) {},
                                  items: <String>['A', 'B', 'C'].map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Text(e),
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
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: CustomDecoration
                                          .containerCornerRadiusDecoration,
                                      child: DropdownButton<String>(
                                        onChanged: (val) {},
                                        items: <String>['A', 'B', 'C'].map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(e),
                                            ),
                                          );
                                        }).toList(),
                                        hint: const Text('Choose Certificate'),
                                        iconSize: 40,
                                        borderRadius: BorderRadius.circular(10),
                                        underline: Container(),
                                        isExpanded: true,
                                        menuMaxHeight: 500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.purple,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Flexible(
                                            child: Text(
                                          'Add',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.purple,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Flexible(
                                            child: Text(
                                          'Choose',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: CustomDecoration
                                    .containerCornerRadiusDecoration,
                                child: TextFormField(
                                  decoration:
                                      CustomDecoration.textFormFieldDecoration(
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
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundImage: pickedFile != null
                                            ? FileImage(
                                                (File("${pickedFile!.path}")))
                                            : const AssetImage(
                                                    "assets/images/add-image.jpg")
                                                as ImageProvider,
                                        radius: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    TextButton(
                                      child: const Text("Select Icon"),
                                      onPressed: () {
                                        selectFile();
                                      },
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const RequiredDocument(),
                              const SizedBox(height: 10),
                              const Steps(),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius: BorderRadius.circular(10)),
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
                      //height: 400,
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
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(
                              height: 40,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: CustomDecoration
                                  .containerCornerRadiusDecoration,
                              child: DropdownButton<String>(
                                onChanged: (val) {},
                                items: <String>['A', 'B', 'C'].map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(e),
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
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: CustomDecoration
                                        .containerCornerRadiusDecoration,
                                    child: DropdownButton<String>(
                                      onChanged: (val) {},
                                      items: <String>['A', 'B', 'C'].map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Text(e),
                                          ),
                                        );
                                      }).toList(),
                                      hint: const Text('Choose Certificate'),
                                      iconSize: 40,
                                      borderRadius: BorderRadius.circular(10),
                                      underline: Container(),
                                      isExpanded: true,
                                      menuMaxHeight: 500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.purple,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Flexible(
                                          child: Text(
                                        'Add',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.purple,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Flexible(
                                          child: Text(
                                        'Choose',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: CustomDecoration
                                  .containerCornerRadiusDecoration,
                              child: TextFormField(
                                decoration:
                                    CustomDecoration.textFormFieldDecoration(
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
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      backgroundImage: pickedFile != null
                                          ? FileImage(
                                              (File("${pickedFile!.path}")))
                                          : const AssetImage(
                                                  "assets/images/add-image.jpg")
                                              as ImageProvider,
                                      radius: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  TextButton(
                                    child: const Text("Select Icon"),
                                    onPressed: () {
                                      selectFile();
                                    },
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const RequiredDocument(),
                            const SizedBox(height: 10),
                            const Steps(),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius: BorderRadius.circular(10)),
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
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;

      if (pickedFile != null) {
        imageFile = File(pickedFile!.path!);
      }
    });
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
    } else
      return null;
  }
}
