import 'package:flutter/material.dart';
import 'package:savr/history.dart';
import 'package:savr/product_page.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var db = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List>(
            future: db.queryAllWords(),
            initialData: List(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, int position) {
                        final item = snapshot.data[position];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                            barcode: item.barcode,
                                          )));
                            },
                            title: Text(item.product + " " + item.barcode),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No history',
                      ),
                    );
            }));
  }
}
