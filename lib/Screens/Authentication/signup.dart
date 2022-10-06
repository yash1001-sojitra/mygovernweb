// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Logic/Modules/admindata/user_model.dart';
import '../../Logic/provider/userData_provider.dart';
import '../../Logic/services/auth_services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                height: 600,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white.withAlpha(230),
                  child: const SignUpForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late AuthService authService;
  bool showLoading = false;
  bool showAlert = false;
  bool ispasswordvisible = true;
  final _form = GlobalKey<FormState>();

  bool _isValid = false;

  void _saveForm() {
    setState(() {
      _isValid = _form.currentState!.validate();
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLogin = true;
  @override
  Widget build(BuildContext context) {
    authService = Provider.of<AuthService>(context);
    final userDataProvider = Provider.of<UsereDataProvider>(context);

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
                  Text(
                    _isLogin ? 'Login' : 'SignUp',
                    style: const TextStyle(
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
                            onChanged: (value) {
                              _isLogin
                                  ? ""
                                  : userDataProvider.changeEmail(value);
                            },
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
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: TextFormField(
                            onChanged: (value) {},
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: "Password",
                                hintText: "password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () async {
                          if (_isLogin) {
                            setState(() {
                              showLoading = true;
                            });
                            progressIndicater(context, showLoading = true);
                            await loginByRole();
                            showAlert == true
                                ? null
                                : progressIndicater(
                                    context, showLoading = false);

                            Get.offAllNamed('/home');
                          } else {
                            setState(() {
                              showLoading = true;
                            });
                            progressIndicater(context, showLoading = true);
                            FireBaseUser? user = await createUser();
                            userDataProvider.changeId(user!.uid);
                            userDataProvider.saveUserData();
                            showAlert == true
                                ? null
                                : progressIndicater(
                                    context, showLoading = true);
                            Navigator.pop(context);
                            emailController.clear();
                            passwordController.clear();
                          }
                          // Get.toNamed('/home');
                        },
                        icon: const Icon(Icons.login),
                        label: Text(_isLogin ? 'Login' : 'Register'),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () async {
                          await userDataProvider.signInWithGoogle();
                          // await GoogleSignIn().signIn();
                          Get.toNamed('/home');
                        },
                        icon: SizedBox(
                          height: 25,
                          child: Image.asset('assets/images/google.png'),
                        ),
                        label: const Text("Google SignIn"),
                      ),
                      const SizedBox(height: 20),
                      if (_isLogin)
                        GestureDetector(
                            onTap: () {
                              Get.toNamed('/forgotpass');
                            },
                            child: const Text("Forgot Password?")),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() => _isLogin = !_isLogin);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_isLogin
                                ? 'New User?'
                                : 'Already have an account?'),
                            Text(
                              _isLogin
                                  ? ' Click here for SignUp'
                                  : ' Click here for Login',
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              )),
        ),
      ),
    );
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

  createUser() async {
    try {
      FireBaseUser? user = await authService.createUserWithEmailAndPassword(
          emailController.text.toString(), passwordController.text.toString());

      Navigator.pop(context);
      // Navigator.pushReplacementNamed(context, "/home");

      // Get.toNamed('/home');

      return user;
    } catch (e) {
      return alertBox(context, e);
    }
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

  loginByRole() async {
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text.toString(), passwordController.text.toString());
      Get.toNamed('/home');
      // Navigator.pushNamedAndRemoveUntil(
      //     context, homepageScreenRoute, (route) => false);
    } catch (e) {
      return alertBox(context, e);
    }
  }
}
