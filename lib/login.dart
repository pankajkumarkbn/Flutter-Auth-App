import 'package:flutter/material.dart';
import 'package:flutter_demo_app/auth.dart';

class LoginPage extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  LoginPage({@required this.auth, @required this.onSignedIn});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: Center(
          child: RaisedButton(
            color: Colors.white,
            elevation: 4.0,
            onPressed: () async {
              await auth.googleSignIn();
              try {
                if (await auth.currentUser() != null) {
                  onSignedIn();
                }
              } catch(e) {
                print("Error in sign in.");
              }
            },
            child: Text("GOOGLE SIGN IN"),
          ),
        ),
      ),
    );
  }
}
