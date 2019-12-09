import 'package:flutter/material.dart';
import 'package:savr/product_page.dart';
import 'barcode_scan.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>  ProductPage(barcode: "Test",)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5ACEFF),
      body: Center(
        child: Text(
          'Savr',
          style: TextStyle(
            color: Colors.white,
            fontSize: 55.0,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
