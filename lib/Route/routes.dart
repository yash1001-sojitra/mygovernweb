// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mygovernweb/Screens/Authentication/forgotpass.dart';
import 'package:mygovernweb/Screens/Authentication/signup.dart';
import 'package:mygovernweb/Screens/HomeScreen/adminpanel.dart';
import 'package:mygovernweb/Screens/requests/requests_list.dart';

import '../Screens/addOrEdit/addcategory.dart';
import '../Screens/addOrEdit/addnewdoc.dart';
import '../Screens/addOrEdit/editdoc.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler _signUpHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          SignUpScreen());
  static Handler _ForgotpassHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          ForgotpassScreen());
  static Handler _HomescreenHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          DashBoard());
  static Handler _RequestScreenHander = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          RequestsList());
  static Handler _AddCategoryHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          AddCategory());
  static Handler _AddnewdocHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          AddnewDoc());

  static Handler _EditDocHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          EditDoc());

  static void setUpRouter() {
    router.define('/',
        handler: _signUpHandler, transitionType: TransitionType.fadeIn);
    router.define('/forgotpass',
        handler: _ForgotpassHandler, transitionType: TransitionType.fadeIn);
    router.define('/home',
        handler: _HomescreenHandler, transitionType: TransitionType.fadeIn);
    router.define('/Request_screen',
        handler: _RequestScreenHander, transitionType: TransitionType.fadeIn);
    router.define('/Add_category',
        handler: _AddCategoryHandler, transitionType: TransitionType.fadeIn);
    router.define('/Add_new_doc',
        handler: _AddnewdocHandler, transitionType: TransitionType.fadeIn);
    router.define('/Edit_doc',
        handler: _EditDocHandler, transitionType: TransitionType.fadeIn);
  }
}
