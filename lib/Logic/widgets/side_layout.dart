// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mygovernweb/Logic/widgets/sidebar_item.dart';

class SideLayout extends StatefulWidget {
  final int pageIndex;

  SideLayout({required this.pageIndex});

  @override
  State<SideLayout> createState() => _SideLayoutState();
}

class _SideLayoutState extends State<SideLayout> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 500,
      child: Column(
        children: [
          SizedBox(height: 70),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Image.asset(
                "assets/images/Mygov.png",
                width: 56,
                height: 56,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SideBarItem(title: "Log Out", isSelected: widget.pageIndex == 0),
        ],
      ),
    );
  }
}
