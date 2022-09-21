// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mygovernweb/Logic/widgets/addOrEdit/addcategory.dart';
import 'package:mygovernweb/Logic/widgets/addOrEdit/addnewdoc.dart';
import 'package:mygovernweb/Logic/widgets/addOrEdit/editdoc.dart';
import 'package:mygovernweb/Screens/Authentication/login.dart';
import 'package:mygovernweb/Screens/Authentication/signup.dart';
import 'package:mygovernweb/Screens/HomeScreen/homescreen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();
  static Handler _loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          LoginScreen());

  static Handler _signUpHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          SignUpScreen());

  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          HomePage());
  static Handler _AddCategoryHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          AddCategory());
  static Handler _AddNewDocHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          AddNewDoc());
  static Handler _EditDocHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          EditDoc());

  static void setUpRouter() {
    router.define('/',
        handler: _signUpHandler, transitionType: TransitionType.fadeIn);
    /* router.define('/',
        handler: _loginHandler, transitionType: TransitionType.fadeIn); */
    router.define('/Add_category',
        handler: _AddCategoryHandler, transitionType: TransitionType.fadeIn);
    router.define('/Add_new_doc',
        handler: _AddNewDocHandler, transitionType: TransitionType.fadeIn);
    router.define('/Edit_doc',
        handler: _EditDocHandler, transitionType: TransitionType.fadeIn);
  }
}
