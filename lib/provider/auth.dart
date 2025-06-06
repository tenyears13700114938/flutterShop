import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth with ChangeNotifier {
  late UserCredential _userCredential;

  bool _isLogin = false;

  String? _uid;

  bool get isLogin => _isLogin;

  String? get uid => _uid;

  Auth() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      _isLogin = user != null && user.emailVerified;
      _uid = user?.uid;
      notifyListeners();
    });
  }

  Future<String?> signUp(String email, String password) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = _userCredential.user;
      if(user != null && !user.emailVerified){
        await user.sendEmailVerification();
        return "Please check your email to verify your account.";
      }
      return null;
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<void> login(String email, String password) async {
    _userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> reloadUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      await user.reload();
      print("myDebug reload user..");
    }
  }
}
