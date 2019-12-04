import 'package:flutter/material.dart';

class BarcodeScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Scan',
          ),
        ),
      ),
      body: Center(
        child: Text(
          'hi',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
