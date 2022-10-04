import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygovernweb/Logic/widgets/admin_card.dart';

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
    if (deviceSize.width < 764) {
      setState(() {
        isExpanded = false;
      });
    }
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Stack(children: [
          //const BackgroundImage(),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = false;
              });
            },
            child: Container(
              color: Colors.grey.shade200,
            ),
          ),
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
                //backgroundColor: Colors.deepPurple.shade400.withOpacity(0.7),
                backgroundColor: const Color(0xff2d3037),
                /* unselectedIconTheme:
                    const IconThemeData(color: Colors.white, opacity: 1), */
                unselectedIconTheme: const IconThemeData(color: Colors.grey),
                /* unselectedLabelTextStyle: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ), */
                unselectedLabelTextStyle: const TextStyle(
                  color: Colors.grey,
                ),
                /* selectedIconTheme:
                    IconThemeData(color: Colors.deepPurple.shade900), */
                selectedIconTheme: const IconThemeData(color: Colors.white),
                /* selectedLabelTextStyle: const TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.w900), */
                selectedLabelTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900),
                destinations: const [
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
                      deviceSize.width > 768
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              icon: const Icon(Icons.menu))
                          : const SizedBox(),
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
                      const SizedBox(height: 10),
                      const Divider(),
                      SizedBox(height: deviceSize.height * 0.05),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                                padding: deviceSize.width > 768
                                    ? const EdgeInsets.symmetric(horizontal: 10)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 10),
                                child: deviceSize.width > 768
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: const [
                                            AdminCard('add_category',
                                                'Add Cegory', '/Add_category'),
                                            SizedBox(width: 20),
                                            AdminCard(
                                                'add_doc',
                                                'Add New Document',
                                                '/Add_new_doc'),
                                            SizedBox(width: 20),
                                            AdminCard('edit_doc',
                                                'Edit Document', '/Edit_doc'),

                                            /* AddCard(
                                              imgpath:
                                                  "assets/images/category.png",
                                              title: category[0],
                                              routename: "/Add_category"),
                                          AddCard(
                                              imgpath: "assets/images/add.png",
                                              title: category[1],
                                              routename: "/Add_new_doc"),
                                          AddCard(
                                            imgpath: "assets/images/edit.png",
                                            title: category[2],
                                            routename: "/Edit_doc",
                                          ), */
                                          ],
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          /* AddCard(
                                        imgpath:
                                            "assets/images/category.png",
                                        title: category[0],
                                        routename: "/Add_category"),
                                        const SizedBox(height: 10),
                                        AddCard(
                                        imgpath: "assets/images/add.png",
                                        title: category[1],
                                        routename: "/Add_new_doc"),
                                        const SizedBox(height: 10),
                                        AddCard(
                                      imgpath: "assets/images/edit.png",
                                      title: category[2],
                                      routename: "/Edit_doc",
                                        ), */
                                          AdminCard('add_category',
                                              'Add category', '/Add_category'),
                                          SizedBox(height: 20),
                                          AdminCard(
                                              'add_doc',
                                              'Add New Document',
                                              '/Add_new_doc'),
                                          SizedBox(height: 20),
                                          AdminCard('edit_doc', 'Edit Document',
                                              '/Edit_doc'),
                                        ],
                                      )),
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
      ),
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
  String routename;
  AddCard(
      {required this.imgpath,
      required this.title,
      required this.routename,
      super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(widget.routename);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 220,
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.deepPurple.shade400.withOpacity(0.3),
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
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
                    style: const TextStyle(
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
      ),
    );
  }
}
