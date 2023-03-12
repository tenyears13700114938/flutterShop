import 'package:firebase_auth/firebase_auth.dart';

extension ErrorMessage on FirebaseAuthException {
  String getErrorMessage() {
    var errorMessage = "";
    switch (code) {
      case 'weak-password':
        errorMessage = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        errorMessage = 'The account already exists for that email.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password provided for that user.';
        break;
    }
    return errorMessage;
  }
}
