// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'option.dart';

class OptionCard extends StatefulWidget {
  const OptionCard({Key? key}) : super(key: key);

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: deviceSize.width > 768
          ? EdgeInsets.symmetric(horizontal: 75.0)
          : EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        width: deviceSize.width,
        child: Padding(
          padding: deviceSize.width > 768
              ? EdgeInsets.symmetric(horizontal: 50.0, vertical: 50)
              : EdgeInsets.symmetric(horizontal: 20),
          child: deviceSize.width > 768
              ? deviceSize.width > 1250
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Option(
                          imgPath: "assets/images/generate_paper.svg",
                          title: "Add \nCategory",
                        ),
                        Option(
                          imgPath: "assets/images/generate_paper.svg",
                          title: "Add \nNew Document",
                        ),
                        Option(
                          imgPath: "assets/images/question_bank.svg",
                          title: "Edit \n Document",
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Option(
                              imgPath: "assets/images/generate_paper.svg",
                              title: "Add \nCategory",
                            ),
                            Option(
                              imgPath: "assets/images/generate_paper.svg",
                              title: "Add \nNew Document",
                            ),
                            Option(
                              imgPath: "assets/images/question_bank.svg",
                              title: "Edit \n Document",
                            ),
                          ],
                        ),
                      ],
                    )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Option(
                        imgPath: "assets/images/generate_paper.svg",
                        title: "Add \nCategory",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Option(
                        imgPath: "assets/images/generate_paper.svg",
                        title: "Add \nNew Document",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Option(
                        imgPath: "assets/images/question_bank.svg",
                        title: "Edit \n Document",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
