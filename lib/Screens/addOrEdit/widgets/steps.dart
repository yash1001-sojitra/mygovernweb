import 'package:flutter/material.dart';

import '../../../Logic/widgets/decoration.dart';

class Steps extends StatefulWidget {
  final List<String> documentwidget;
  const Steps(this.documentwidget, {super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  //List<String> widget.documentwidget = [];

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
          ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: widget.documentwidget.length,
            itemBuilder: ((context, index) {
              return Stack(
                key: UniqueKey(),
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.documentwidget.removeAt(index);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 25),
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ReorderableDragStartListener(
                    index: index,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: Text(widget.documentwidget[index])),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
            physics: const BouncingScrollPhysics(),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = widget.documentwidget.removeAt(oldIndex);
                widget.documentwidget.insert(newIndex, item);
              });
            },
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
                        widget.documentwidget.add(
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
