import 'package:flutter/material.dart';

import '../../../Logic/widgets/decoration.dart';

class RequiredDocument extends StatefulWidget {
  final List<String> documentwidget;
  const RequiredDocument(this.documentwidget, {super.key});

  @override
  State<RequiredDocument> createState() => _RequiredDocumentState();
}

class _RequiredDocumentState extends State<RequiredDocument> {
  int i = 0;
  final controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _focusScope = FocusNode();

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
            itemCount: widget.documentwidget.length,
            itemBuilder: ((context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  key: UniqueKey(),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.documentwidget[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 20),
                        ),
                      )),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.documentwidget.removeAt(index);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
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
                      border: _focusScope.hasFocus
                          ? Border.all(color: Colors.blue)
                          : Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        focusNode: _focusScope,
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter Document Name',
                          border: InputBorder.none,
                        ),
                        validator: (val) {
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
                      FocusScope.of(context).requestFocus(_focusScope);
                      if (controller.text.isNotEmpty) {
                        widget.documentwidget.add(
                            '${controller.text.trim()[0].toUpperCase()}${controller.text.trim().substring(1)}');
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
