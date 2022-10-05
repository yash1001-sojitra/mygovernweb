import 'package:flutter/material.dart';
import 'package:mygovernweb/Screens/addOrEdit/widgets/requireddoc.dart';
import 'package:mygovernweb/Screens/addOrEdit/widgets/steps.dart';

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
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white.withOpacity(0.7),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width:
                      size.width < 1000 ? size.width * 0.90 : size.width * 0.40,
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
                              flex: 7,
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
                            const CircleAvatar(
                              radius: 30,
                              /*   height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.purple,
                              ), */
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FittedBox(
                                    child: Text(
                                  'Add',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const CircleAvatar(
                              radius: 30,
                              /*  height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.purple,
                              ), */
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FittedBox(
                                    child: Text(
                                  'Choose',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
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
                            decoration:
                                CustomDecoration.textFormFieldDecoration(
                                    "Document Name"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const RequiredDocument(),
                        const SizedBox(height: 10),
                        const Steps(),
                      ],
                    ),
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
