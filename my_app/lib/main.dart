import 'package:flutter/material.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/pages/root-page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Cooking',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.red,
        ),
        home: new RootPage(auth: new Auth())
    );
  }
}
