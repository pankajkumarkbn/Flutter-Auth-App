import 'package:flutter/material.dart';
import 'package:flutter_demo_app/auth.dart';
import 'root.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AUTH DEMO APP',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}
