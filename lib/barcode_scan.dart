import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:savr/product_page.dart';
import 'history.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    _scanBarcode = barcodeScanRes;
    setState(() {
      if (barcodeScanRes != '-1') {
        _save(_scanBarcode);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      barcode: _scanBarcode,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(builder: (BuildContext context) {
        return Container(
            alignment: Alignment.center,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      color: Color(0xFF5ACEFF),
                      textColor: Colors.white,
                      onPressed: () => scanBarcodeNormal(),
                      child: Text("Start barcode scan")),
                ]));
      }),
    );
  }

  _save(String barcode) async {
    Word word = Word();
    word.product = "product";
    word.barcode = barcode;
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.insert(word);
  }
}
