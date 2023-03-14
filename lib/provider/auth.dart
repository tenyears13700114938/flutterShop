import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth with ChangeNotifier {
  late UserCredential _userCredential;

  bool _isLogin = false;

  String? _uid;

  bool get isLogin => _isLogin;

  String? get uid => _uid;

  Auth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _isLogin = user != null;
      _uid = user?.uid;
      notifyListeners();
    });
  }

  Future<void> signUp(String email, String password) async {
    _userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> login(String email, String password) async {
    _userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
  }
}
