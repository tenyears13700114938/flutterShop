import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth with ChangeNotifier {
  late UserCredential _userCredential;

  Future<void> signUp(String email, String password) async {
    _userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    print(_userCredential.credential);
    print(_userCredential.user);
  }
}
