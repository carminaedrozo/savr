import 'package:flutter/material.dart';
import 'package:savr/welcome_page.dart';

void main() => runApp(Savr());

class Savr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontFamily: 'OpenSans',
            fontSize: 20.0,
          ),
        ),
      ),
      home: WelcomePage(),
    );
  }
}
