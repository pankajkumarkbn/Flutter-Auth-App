import 'package:flutter/material.dart';
import 'package:flutter_demo_app/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignOut;

  MyHomePage({@required this.auth, @required this.onSignOut});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _userName = '';
  String _userEmail = '';
  String _userPhotoUrl = '';
  bool _isEmailVerified = false;
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
        _userName = _currentUser["displayName"];
        _userEmail = _currentUser['email'];
        _userPhotoUrl = _currentUser['photoUrl'];
        _isEmailVerified = _currentUser['isEmailVerified'];
      });
    } catch (e) {
      print("Current User Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("AUTH DEMO APP"),
      ),
      body: _currentUser != null ?  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(backgroundImage: CachedNetworkImageProvider(_userPhotoUrl), radius: 36.0,),
            Text("USER : $_userName"),
            Text("EMAIL : $_userEmail"),
            Text("VERIFIED EMAIL : $_isEmailVerified"),
            SizedBox(
              height: 24.0,
            ),
            RaisedButton(
              onPressed: () {
                widget.auth.signOut();
                widget.onSignOut();
              },
              child: Text("SIGN OUT"),
            ),
          ],
        ),
      ) : null,
    );
  }
}
