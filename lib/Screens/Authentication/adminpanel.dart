import 'package:flutter/material.dart';


class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isExpanded = false;
  int _selected_index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
              backgroundColor: Colors.deepPurple.shade400,
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
                    icon: Icon(Icons.chat_rounded),
                    label: Text("chart"),
                    selectedIcon: Icon(Icons.chat_rounded)),
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
          SingleChildScrollView(
            child: Row(
              children:[
                Column(children: [
               
                IconButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    icon: Icon(Icons.menu))
              ]),

              
              ] 
            ),
          )
        ],
      ),
    );
  }
}
