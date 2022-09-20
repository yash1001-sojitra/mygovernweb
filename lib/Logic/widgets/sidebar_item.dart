// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideBarItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  SideBarItem({required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isSelected
            ? SvgPicture.asset("assets/images/rectangle.svg")
            : SizedBox(
                width: 7,
              ),
        Flexible(
          child: TextButton(
            onPressed: () async {},
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: "calibri",
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
