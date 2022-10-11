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
            'Document Steps/Procedure',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Divider(),
          ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: widget.documentwidget.length,
            itemBuilder: ((context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                key: UniqueKey(),
                child: Container(
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
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: InkWell(
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
                        ),
                      )
                    ],
                  ),
                ),
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
                      //*  */border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                      border: _focusScope.hasFocus
                          ? Border.all(color: Colors.blue)
                          : Border.all(color: Colors.grey),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        focusNode: _focusScope,
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
                    FocusScope.of(context).requestFocus(_focusScope);
                    setState(() {
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


/* 
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
 */