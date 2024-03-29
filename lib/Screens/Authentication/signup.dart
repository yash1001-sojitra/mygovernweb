// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Logic/Modules/admindata/user_model.dart';
import '../../Logic/provider/userData_provider.dart';
import '../../Logic/services/auth_services/auth_service.dart';
import '../HomeScreen/adminpanel.dart';

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
      body: StreamBuilder<FireBaseUser?>(
          stream: Provider.of<AuthService>(context).user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data != null) {
              return DashBoard();
            }

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff59bcdd), Color(0xffdf39f7)]),
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
            );
          }),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  late AuthService authService;
  bool _loginLoading = false;

  bool ispasswordvisible = true;
  final _form = GlobalKey<FormState>();
  String? error;

  final bool _isValid = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    authService = Provider.of<AuthService>(context, listen: false);

    final userDataProvider =
        Provider.of<UsereDataProvider>(context, listen: false);
    emailController.text = "a@g.com";
    passwordController.text = "12345678";
    return _loginLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _form,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
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
                                    if (!RegExp(r'\S+@\S+\.\S+')
                                        .hasMatch(value)) {
                                      return "Please enter a valid email address";
                                    }

                                    // the email is valid
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      icon:
                                          Icon(Icons.alternate_email_outlined),
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
                                    bottom:
                                        BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextFormField(
                                  onChanged: (value) {},
                                  controller: passwordController,
                                  obscureText: true,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Enter password!';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.lock),
                                      labelText: "Password",
                                      hintText: "password",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            if (error != null)
                              Text(
                                error ?? '',
                                style: const TextStyle(color: Colors.red),
                              ),
                            const SizedBox(height: 15),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50)),
                              onPressed: () async {
                                if (_isLogin) {
                                  if (!_form.currentState!.validate()) return;
                                  setState(() => _loginLoading = true);
                                  String? loginInfo = await loginByRole();
                                  setState(() {
                                    _loginLoading = false;
                                    if (loginInfo != null) {
                                      error = loginInfo;
                                    } else {
                                      error = null;
                                    }
                                  });
                                } else {
                                  FireBaseUser? user = await createUser();
                                  userDataProvider.changeId(user!.uid);
                                  userDataProvider.saveUserData();
                                  emailController.clear();
                                  passwordController.clear();
                                }
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
                                //Get.offAndToNamed('/home');
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
      return user;
    } catch (e) {
      return alertBox(context, e);
    }
  }

  Future<void> alertBox(BuildContext context, e) {
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

  Future<String?> loginByRole() async {
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text.trim().toString(),
          passwordController.text.trim().toString());
      Get.offAndToNamed('/home');
      return null;
      // Navigator.pushNamedAndRemoveUntil(
      //     context, homepageScreenRoute, (route) => false);
    } catch (e) {
      return e.toString();
    }
  }
}
