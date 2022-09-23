import 'package:flutter/material.dart';

import '../../Logic/widgets/decoration.dart';

class AddnewDoc extends StatelessWidget {
  const AddnewDoc({super.key});

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
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white.withOpacity(0.7),
              child: Container(
                padding: const EdgeInsets.all(15),
                //height: 400,
                width: size.width * 0.35,
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
                        decoration:
                            CustomDecoration.containerCornerRadiusDecoration,
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
                                      fontSize: 20, color: Colors.white),
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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration:
                            CustomDecoration.containerCornerRadiusDecoration,
                        child: TextFormField(
                          decoration: CustomDecoration.textFormFieldDecoration(
                              "Document Name"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const RequiredDocument(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RequiredDocument extends StatefulWidget {
  const RequiredDocument({super.key});

  @override
  State<RequiredDocument> createState() => _RequiredDocumentState();
}

class _RequiredDocumentState extends State<RequiredDocument> {
  List<Widget> documentwidget = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: CustomDecoration.containerCornerRadiusDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: documentwidget.length,
            itemBuilder: ((context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    documentwidget[index],
                    InkWell(
                      onTap: () {
                        setState(() {
                          documentwidget.removeAt(index);
                        });
                      },
                      child: CircleAvatar(
                        child: Text('$index'),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.purple.shade300),
            ),
            onPressed: () {
              setState(() {
                documentwidget.add(Container(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('A'),
                  ),
                ));
              });
            },
            child: const Text('Add New'),
          ),
        ],
      ),
    );
  }
}
