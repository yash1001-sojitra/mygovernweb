import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mygovernweb/Route/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    Flurorouter.setUpRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Govern',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Flurorouter.router.generator,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
  }
}
