import 'package:flutter/material.dart';

import '../../../Logic/widgets/decoration.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  List<String> documentwidget = ['adhgsafd'];

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
            'Document Steps/Procedure',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: documentwidget.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(documentwidget[index])),
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
                          hintText: 'Enter Step',
                          border: InputBorder.none,
                        ),
                        validator: (val) {
                          print('..............');
                          if (val == null || val.isEmpty) {
                            return 'Enter Document Step';
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
                        documentwidget.add(
                          controller.text.trim(),
                        );
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
