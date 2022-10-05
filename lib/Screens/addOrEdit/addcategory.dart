import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../../Logic/widgets/decoration.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  late File imageFile;
  PlatformFile? pickedFile;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    // final CategorydataProvider = Provider.of<CategoryDataProvider>(context);
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
                                    // CategorydataProvider.changeCategoryName(
                                    //     value);
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
<<<<<<< HEAD
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
=======
                                    Container(
                                        height: 50,
                                        width: 50,
                                        child: _pickedimage == null
                                            ? Image.asset(
                                                "assets/images/add-image.png")
                                            : kIsWeb
                                                ? Image.memory(webImage)
                                                : Image.file(_pickedimage!)),
>>>>>>> d0ee4e98e9492e47068af751f668025ccb2f914f
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
                                        selectFile();
                                      },
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  // setState(() {
                                  //   showLoading = true;
                                  // });
                                  // progressIndicater(
                                  //     context, showLoading = true);
                                  // final ref = FirebaseStorage.instance
                                  //     .ref()
                                  //     .child('url')
                                  //     .child(pickedFile!.name.toString());
                                  // await ref.putFile(imageFile);
                                  // String url = await ref.getDownloadURL();
                                  // CategorydataProvider.changeUrl(url);
                                  // CategorydataProvider.changetime(
                                  //     DateTime.now());
                                  // CategorydataProvider.saveCategoryData();

                                  // setState(() {
                                  //   showLoading = false;
                                  // });
                                  // Navigator.pop(context);
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
<<<<<<< HEAD
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
=======
                                  Container(
                                      height: 50,
                                      width: 50,
                                      child: _pickedimage == null
                                          ? Image.asset(
                                              "assets/images/add-image.png")
                                          : kIsWeb
                                              ? Image.memory(webImage)
                                              : Image.file(_pickedimage!)),
>>>>>>> d0ee4e98e9492e47068af751f668025ccb2f914f
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
                                      selectFile();
                                    },
                                  )
                                ],
                              ),
                            ),
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
                )
        ],
      ),
    );
  }

<<<<<<< HEAD
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;

      if (pickedFile != null) {
        imageFile = File(pickedFile!.path!);
      }
    });
=======
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
>>>>>>> d0ee4e98e9492e47068af751f668025ccb2f914f
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
