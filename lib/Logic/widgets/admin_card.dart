import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCard extends StatelessWidget {
  final String imageName;
  final String title;
  final String route;
  const AdminCard(this.imageName, this.title, this.route, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Get.toNamed(route);
      },
      child: Card(
        shadowColor: const Color(0xff2d3037),
        elevation: 5,
        child: SizedBox(
          width: size.width > 1160 ? size.width * 0.18 : 250,
          height: size.height > 400 ? size.height * 0.25 : 350,
          /* width:  size.width > 800 ? size.width * 0.22 : 250,
          height: size.height > 400 ? size.height * 0.25 : 350, */
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4, child: Image.asset('assets/images/$imageName.png')),
              const Divider(),
              Expanded(
                  flex: 2,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
