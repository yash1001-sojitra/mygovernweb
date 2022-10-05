import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mygovernweb/Logic/provider/categorydata_provider.dart';
import 'package:mygovernweb/Route/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // await Firebase.initializeApp();

  runApp(
    const MyApp()
  //   MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider.value(
  //       value: CategoryDataProvider(),
  //     ),
  //   ],
  //   child: const MyApp(),
  // )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
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
