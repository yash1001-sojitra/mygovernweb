// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Logic/services/auth_services/auth_service.dart';

class ForgotpassScreen extends StatefulWidget {
  const ForgotpassScreen({super.key});

  @override
  State<ForgotpassScreen> createState() => _FotgotpassScreenState();
}

class _FotgotpassScreenState extends State<ForgotpassScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff59bcdd), Color(0xffdf39f7)]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (deviceSize.width > 1100)
              Lottie.asset('assets/animations/login_animation.json'),
            Center(
              child: SizedBox(
                width: 400,
                height: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white.withAlpha(230),
                  child: const FotgotpassForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FotgotpassForm extends StatefulWidget {
  const FotgotpassForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FotgotpassFormState createState() => _FotgotpassFormState();
}

class _FotgotpassFormState extends State<FotgotpassForm> {
  late AuthService authService;
  bool showLoading = false;
  bool showAlert = false;
  final _form = GlobalKey<FormState>();
  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _form.currentState!.validate();
    });
  }

  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // authService = Provider.of<AuthService>(context);
    // final userDataProvider = Provider.of<UsereDataProvider>(context);

    return Form(
      key: _form,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          physics: const PageScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200))),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }

                              // using regular expression
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email address";
                              }

                              // the email is valid
                              return null;
                            },
                            decoration: const InputDecoration(
                                icon: Icon(Icons.alternate_email_outlined),
                                labelText: "Email",
                                hintText: "Email",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () async {
                          _saveForm();
                          if (_isValid) {
                            progressIndicater(context, true);

                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: emailController.toString())
                                .then((value) => Navigator.of(context).pop());
                            progressIndicater(context, false);
                            Get.toNamed('/');
                          }
                        },
                        icon: const Icon(CupertinoIcons.lock),
                        label: const Text('Forgot Password'),
                      ),
                    ],
                  ),
                ]),
              )),
        ),
      ),
    );
  }

  Future<void> alertBox(BuildContext context, e) {
    setState(() {
      showLoading = false;
      showAlert = true;
    });
    return Alert(
      context: context,
      padding: const EdgeInsets.only(left: 10, right: 10),
      title: "ALERT",
      style: const AlertStyle(
        descTextAlign: TextAlign.center,
      ),
      desc: e.toString(),
    ).show();
  }

  Future<dynamic>? progressIndicater(BuildContext context, showLoading) {
    if (showLoading == true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
                child: Lottie.asset("assets/animations/lodingtrans.json",
                    height: 50, width: 50)
                // CircularProgressIndicator(),
                );
          });
    } else {
      return null;
    }
  }
}
