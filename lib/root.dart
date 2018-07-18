import 'package:flutter/material.dart';
import 'package:flutter_demo_app/auth.dart';
import 'package:flutter_demo_app/home.dart';
import 'package:flutter_demo_app/login.dart';

enum AuthStatus { notSignedIn, signedIn }

class RootPage extends StatefulWidget {
  final BaseAuth auth;

  const RootPage({@required this.auth});

  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  Map<String, dynamic> _currentUser;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkCurrentUser() async {
    try {
      _currentUser = await widget.auth.currentUser();
      setState(() {
        if (_currentUser != null) {
          _authStatus = AuthStatus.signedIn;
        } else {
          _authStatus = AuthStatus.notSignedIn;
        }
      });
      print("CURRENT USER ::::  $_currentUser");
    } catch (e) {
      print("CUREENT USER :::: NUll");
    }
  }

  void onSignedIn() async {
    setState(() {
        _authStatus = AuthStatus.signedIn;
    });
  }

  void onSignedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_authStatus == AuthStatus.notSignedIn) {
      return new LoginPage(
        auth: widget.auth,
        onSignedIn: onSignedIn,
      );
    }
    return MyHomePage(
      auth: widget.auth,
      onSignOut: onSignedOut,
    );
  }
}
