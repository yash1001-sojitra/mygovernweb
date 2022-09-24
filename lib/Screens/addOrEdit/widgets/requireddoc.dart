import 'package:flutter/material.dart';

import '../../../Logic/widgets/decoration.dart';

class RequiredDocument extends StatefulWidget {
  const RequiredDocument({super.key});

  @override
  State<RequiredDocument> createState() => _RequiredDocumentState();
}

class _RequiredDocumentState extends State<RequiredDocument> {
  List<String> documentwidget = [];
  int i = 0;
  final controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: CustomDecoration.containerCornerRadiusDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Required Document',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: documentwidget.length,
            itemBuilder: ((context, index) {
              return Container(
                key: UniqueKey(),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(documentwidget[index]),
                    )),
                    InkWell(
                      onTap: () {
                        setState(() {
                          documentwidget.removeAt(index);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          Container(
            decoration: CustomDecoration.containerCornerRadiusDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter Document Name',
                          border: InputBorder.none,
                        ),
                        validator: (val) {
                          print('..............');
                          if (val == null || val.isEmpty) {
                            return 'Enter Document Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _formKey.currentState?.validate();
                    setState(() {
                      if (controller.text.isNotEmpty) {
                        documentwidget.add(controller.text.trim());
                        controller.clear();
                      }
                    });
                  },
                  child: const Expanded(
                    child: CircleAvatar(
                      radius: 30,
                      child: Center(
                        child: Text('Add'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
