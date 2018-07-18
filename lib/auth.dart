import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future googleSignIn(); //  Google Sign In
  Future<Map<String, dynamic>> currentUser(); //  Current User
  void signOut(); //  Sign Out
}

class Auth implements BaseAuth {
  Future googleSignIn() async {
    GoogleSignIn googleSignIn = new GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication;

    try {
      googleSignInAuthentication = await googleSignInAccount.authentication;
      FirebaseUser _user = await FirebaseAuth.instance.signInWithGoogle(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
    } catch (e) {
      print("Error in google authentication");
    }

  }

  Future<Map<String, dynamic>> currentUser() async {
    Map<String, dynamic> _userData;

    FirebaseUser _user = await FirebaseAuth.instance.currentUser();

    _userData = <String, dynamic>{
      "uid": _user.uid,
      "photoUrl": _user.photoUrl,
      "displayName": _user.displayName,
      "email": _user.email,
      "isAnonymous": _user.isAnonymous,
      "isEmailVerified": _user.isEmailVerified,
      "providerData": _user.providerData,
    };
    return _userData;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    new GoogleSignIn().signOut();
  }
}
