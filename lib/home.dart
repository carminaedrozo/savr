import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:savr/history_page.dart';
import 'barcode_scan.dart';
import 'package:savr/history.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var db = DatabaseHelper.instance;
  int _currentIndex = 0;
  final List<Widget> _children = [
    HistoryPage(),
    Scan(),
    Loading(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Savr'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline),
            color: Colors.black,
            onPressed: () {
              _showDialog();
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.history,
              color: Colors.white,
            ),
            title: new Text(
              'History',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.barcode,
              color: Colors.white,
            ),
            title: new Text(
              'Scan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        backgroundColor: Color(0xFF5ACEFF),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete history?"),
          content: new Text("This will remove all your barcode history."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Delete"),
              onPressed: () {
                db.deleteAll();
                setState(() {
                  onTabTapped(1);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
