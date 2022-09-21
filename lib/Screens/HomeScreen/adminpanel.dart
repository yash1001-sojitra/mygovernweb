import 'dart:ui';

import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isExpanded = false;
  int _selected_index = 0;
  List category = ["Add Category", "Add New Document", "Edit Document"];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        BackgroundImage(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NavigationRail(
              // labelType: NavigationRailLabelType.selected,
              selectedIndex: _selected_index,
              onDestinationSelected: (int index) {
                setState(() {
                  _selected_index = index;
                });
              },

              extended: isExpanded,
              backgroundColor: Colors.deepPurple.shade400.withOpacity(0.7),
              unselectedIconTheme:
                  IconThemeData(color: Colors.white, opacity: 1),
              unselectedLabelTextStyle: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              selectedIconTheme:
                  IconThemeData(color: Colors.deepPurple.shade900),
              destinations: [
                NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text("Home"),
                    selectedIcon: Icon(Icons.home)),
                NavigationRailDestination(
                    icon: Icon(Icons.logout),
                    label: Text("logout"),
                    selectedIcon: Icon(Icons.logout)),
              ],
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        icon: const Icon(Icons.menu)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/national.png",
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    Expanded(
                      child: Padding(
                        padding: deviceSize.width > 768
                            ? EdgeInsets.symmetric(horizontal: 50.0)
                            : EdgeInsets.symmetric(horizontal: 50),
                        child: deviceSize.width > 768
                            ? deviceSize.width > 1000
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AddCard(
                                          imgpath: "assets/images/category.png",
                                          title: category[0]),
                                      AddCard(
                                          imgpath: "assets/images/add.png",
                                          title: category[1]),
                                      AddCard(
                                          imgpath: "assets/images/edit.png",
                                          title: category[2]),
                                    ],
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AddCard(
                                            imgpath:
                                                "assets/images/category.png",
                                            title: category[0]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        AddCard(
                                            imgpath: "assets/images/add.png",
                                            title: category[1]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        AddCard(
                                            imgpath: "assets/images/edit.png",
                                            title: category[2]),
                                      ],
                                    ),
                                  )
                            : SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AddCard(
                                        imgpath: "assets/images/category.png",
                                        title: category[0]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AddCard(
                                        imgpath: "assets/images/add.png",
                                        title: category[1]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AddCard(
                                        imgpath: "assets/images/edit.png",
                                        title: category[2]),
                                  ],
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Colors.white60],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/dashback.jpg",
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0))),
        ),
      ),
    );
  }
}

class AddCard extends StatefulWidget {
  String imgpath;
  String title;
  AddCard({required this.imgpath, required this.title, super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 220,
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.deepPurple.shade400.withOpacity(0.3),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  widget.imgpath,
                  height: 150,
                  width: 150,
                ),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
