// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesktopAppBar extends StatefulWidget {
  const DesktopAppBar({Key? key}) : super(key: key);

  @override
  State<DesktopAppBar> createState() => _DesktopAppBarState();
}

class _DesktopAppBarState extends State<DesktopAppBar> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      leading: deviceSize.width < 768
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Image(
                image: AssetImage(
                  "assets/images/Mygov.png",
                ),
              ),
            ),
      actions: deviceSize.width < 768
          ? []
          : [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  children: [
                    TextButton(onPressed: () {}, child: Text("Log Out")),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
    );
  }
}
