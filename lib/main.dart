import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mygovernweb/Logic/provider/categorydata_provider.dart';
import 'package:mygovernweb/Route/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Logic/provider/userData_provider.dart';
import 'Logic/services/auth_services/auth_service.dart';
import 'Logic/services/firestore/user_firestore_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(
    // const MyApp()
    MultiProvider(
      providers: [
        StreamProvider.value(
          value: UserDataFirestoreService().getUserData(),
          initialData: null,
        ),
        ChangeNotifierProvider.value(
          value: UsereDataProvider(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<UserDataFirestoreService>(
          create: (_) => UserDataFirestoreService(),
        ),
        ChangeNotifierProvider.value(
          value: CategoryDataProvider(),
        ),
      ],
      child: const MyApp(),
    ),
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
