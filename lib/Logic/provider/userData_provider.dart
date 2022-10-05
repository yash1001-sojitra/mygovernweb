// ignore_for_file: non_constant_identifier_names, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Modules/admindata/userData_model.dart';
import '../services/firestore/user_firestore_services.dart';

class UsereDataProvider with ChangeNotifier {
  final service = UserDataFirestoreService();
  late String _id;
  late String _Name;
  late String _email;
  final DateTime _time = DateTime.now();

  // getter
  String get getId => _id;
  String get getName => _Name;
  String get getEmail => _email;

  // setter
  void changeId(String value) {
    _id = value;
  }

  void changeName(String value) {
    _Name = value;
  }

  void changeEmail(String value) {
    _email = value;
  }

  void saveUserData() {
    var newUserData =
        UserData(email: getEmail, Name: getName, id: getId, time: _time);
    service.saveUser(newUserData);
  }

  void deleteUserData(userId) {
    service.removeUser(userId);
  }

  Future signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        String userid = user!.uid.toString();
        String email = user.email.toString();
        String name = user.displayName.toString();
        String userdbid = UsereDataProvider().getId;
        if (userdbid == userid) {
        } else {
          changeId(userid);
          changeEmail(email);
          changeName(name);

          saveUserData();
          notifyListeners();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
        } else if (e.code == 'invalid-credential') {}
      } catch (e) {}
    }
  }
}
