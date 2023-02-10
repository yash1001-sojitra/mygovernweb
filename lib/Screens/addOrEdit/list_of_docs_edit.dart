import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mygovernweb/Screens/addOrEdit/widgets/requireddoc.dart';

import '../../Logic/widgets/decoration.dart';

// ignore: must_be_immutable
class ListofDocsEdit extends StatefulWidget {
  final String categoryId;
  Map<String, dynamic>? docData;
  ListofDocsEdit(this.categoryId, this.docData, {super.key});

  @override
  State<ListofDocsEdit> createState() => _ListofDocsEditState();
}

class _ListofDocsEditState extends State<ListofDocsEdit> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance
          .collection('Category')
          .doc(widget.categoryId)
          .collection('Documents')
          .get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StatefulBuilder(builder: (context, setState) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: CustomDecoration.containerCornerRadiusDecoration,
                child: DropdownButton<String>(
                  onChanged: (val) {
                    setState(() {
                      final data = snapshot.data!.docs
                          .firstWhere((element) => element.get('Id') == val)
                          .data();
                      widget.docData = data;
                    });
                  },
                  value: widget.docData?['Id'],
                  items: snapshot.data?.docs.map((e) => e).toSet().map((e) {
                    return DropdownMenuItem<String>(
                      value: e.get('Id'),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(e.id),
                      ),
                    );
                  }).toList(),
                  hint: const Text('Document'),
                  iconSize: 40,
                  borderRadius: BorderRadius.circular(10),
                  underline: Container(),
                  isExpanded: true,
                  menuMaxHeight: 500,
                ),
              ),
              if (widget.docData != null)
                RequiredDocument(List<String>.from(widget.docData?['steps'])),
            ],
          );
        });
      },
    );
  }
}
