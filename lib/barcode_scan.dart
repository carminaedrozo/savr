import 'package:flutter/material.dart';

class BarcodeScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF5ACEFF),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Scan',
          ),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.history),
           title: new Text('History'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.texture),
           title: new Text('Scan'),
         ),
         
       ],
     ),
    );
  }
}
