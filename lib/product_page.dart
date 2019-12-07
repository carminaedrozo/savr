import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  ProductPage({@required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Product Page',
          ),
        ),
        body: Text(
          barcode,
        ));
  }
}
