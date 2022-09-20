import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygovernweb/Controller/add_new_doc_controller.dart';

import '../../../Controller/new_controller.dart';

class AddNewDoc extends StatefulWidget {
  const AddNewDoc({super.key});

  @override
  State<AddNewDoc> createState() => _AddNewDocState();
}

class _AddNewDocState extends State<AddNewDoc> {
  final AddNewDocController addnewdocController =
      Get.put(AddNewDocController());
  final PaperGenerateController paperGenerateController =
      Get.put(PaperGenerateController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.only(left: 80, right: 80),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Category ",
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(51, 51, 51, 1),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.black38, width: 0.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Obx(
                            () => DropdownButton(
                              underline: Container(),
                              value: addnewdocController.classValue.value,
                              items: addnewdocController.categoryList.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: e == ""
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              "Select Category",
                                              style: TextStyle(
                                                  fontFamily: "calibri",
                                                  fontSize: 18,
                                                  color: Colors.grey[800]),
                                            ),
                                          )
                                        : Text(e));
                              }).toList(),
                              onChanged: (val) {
                                addnewdocController.getSubjectList(
                                    val.toString(), false);
                                paperGenerateController.className.value =
                                    val.toString();
                                addnewdocController.classValue.value =
                                    val.toString();
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Text("Document Name",
                        style: TextStyle(
                          fontFamily: "calibri",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(51, 51, 51, 1),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: TextFormField(
                      onChanged: (value) {
                        paperGenerateController.testPaperName.value =
                            value.toString();
                      },
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Document name here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => addnewdocController.isSubjectVisible.value
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Subject ",
                              style: TextStyle(
                                fontFamily: "calibri",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(51, 51, 51, 1),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                      color: Colors.black38, width: 0.8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: DropdownButton(
                                    underline: Container(),
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Select Subject",
                                        style: TextStyle(
                                            fontFamily: "calibri",
                                            fontSize: 18,
                                            color: Colors.grey[800]),
                                      ),
                                    ),
                                    value:
                                        addnewdocController.subjectValue.value,
                                    items: addnewdocController.subjectList
                                        .map((e) {
                                      return DropdownMenuItem(
                                          value: e,
                                          child: e == ""
                                              ? const Text(
                                                  "Select Subject",
                                                  style: TextStyle(
                                                      fontFamily: "calibri",
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                                )
                                              : Text(e));
                                    }).toList(),
                                    onChanged: (val) {
                                      addnewdocController.subjectValue.value =
                                          val.toString();
                                      paperGenerateController
                                          .subjectName.value = val.toString();
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : addnewdocController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => !addnewdocController.isChapterName.value
                      ? Container()
                      : Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Time allowed",
                              style: TextStyle(
                                fontFamily: "calibri",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(51, 51, 51, 1),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                  onChanged: (value) {
                                    paperGenerateController.time.value =
                                        value.toString();
                                  },
                                  maxLines: 1,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.white,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  decoration: InputDecoration(
                                    hintText: "Add test time limit",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => !addnewdocController.isChapterName.value
                    ? Container()
                    : Column(
                        children: [
                          Row(
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Instructions",
                                  style: TextStyle(
                                    fontFamily: "calibri",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                    onChanged: (value) {
                                      paperGenerateController
                                          .instruction.value = value.toString();
                                    },
                                    maxLines: 6,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.white,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: "Instruction here",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      color: Colors.blue,
                      child: const Text('Add Document',
                          style: TextStyle(
                              fontFamily: "calibri",
                              fontSize: 25,
                              color: Colors.white)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
