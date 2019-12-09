import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';


Future<List<dynamic>> fetchPosts() async{
  List posts = [];
  var response = await Dio().get("https://frozen-shore-19761.herokuapp.com/api/v1/products",);

  posts = response.data;
  print(response.data);
  return posts;
}

class ProductPage extends StatelessWidget {
  ProductPage({@required this.barcode});

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Products',
          ),
        ),
        body: Builder(builder: (BuildContext context) {

        return Container(
            alignment: Alignment.center,
            );
      }),
      
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.history, color: Colors.white,),
            title: new Text('History',  style: TextStyle(color: Colors.white)),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.texture, color: Colors.white,),
            title: new Text('Scan', style: TextStyle(color: Colors.white)),
          ),
        ],
        backgroundColor: Color(0xFF5ACEFF),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return FutureBuilder<List<dynamic>>(
  future: fetchPosts(), // a previously-obtained Future<String> or null
  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Text('Press button to start.');
      case ConnectionState.active:
      case ConnectionState.waiting:
        //return Text('Awaiting result...');
      case ConnectionState.done:
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        return ScreenOne(snapshot.data);
    }
    return null; // unreachable
  },
);
  }
}

class ScreenOne extends StatelessWidget {
  List<dynamic> posts;

  ScreenOne(this.posts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Page"),),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, i){
          return PostView(posts[i]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.history, color: Colors.white,),
            title: new Text('History',  style: TextStyle(color: Colors.white)),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.texture, color: Colors.white,),
            title: new Text('Scan', style: TextStyle(color: Colors.white)),
          ),
        ],
        backgroundColor: Color(0xFF5ACEFF),
      ),);
  }
}

class PostView extends StatefulWidget {

  Map<String, dynamic> post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Text(widget.post["seller"]),
        Image.network(widget.post["image_url"]),
        Text(widget.post["brand"]),
        
       // Image.network(widget.post["seller_logo"]),

        Text(widget.post["color"]),
        Text(widget.post["price"]),
      ],),
    );
  }
}




/* import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
void main() => runApp(MyApp());

Future<List<dynamic>> fetchPosts() async{
  List posts = [];
  String token = "Bearer ???";
  var response = await Dio().get("https://frozen-shore-19761.herokuapp.com/api/v1/products", 
  options: Options(
    headers: {
      HttpHeaders.authorizationHeader: token, // set content-length
    },
  ),);

  posts = response.data;
  print(response.data);
  return posts;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return FutureBuilder<List<dynamic>>(
  future: fetchPosts(), // a previously-obtained Future<String> or null
  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Text('Press button to start.');
      case ConnectionState.active:
      case ConnectionState.waiting:
        //return Text('Awaiting result...');
      case ConnectionState.done:
        if (snapshot.hasError)
          return Text('Error: ${snapshot.error}');
        return ScreenOne(snapshot.data);
    }
    return null; // unreachable
  },
);
  }
}

class ScreenOne extends StatelessWidget {
  List<dynamic> posts;

  ScreenOne(this.posts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Instagram"),),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, i){
          return PostView(posts[i]);
        },
      ),);
  }
}

class PostView extends StatefulWidget {

  Map<String, dynamic> post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Text(widget.post["seller"]),
        Image.network(widget.post["image_url"]),
        Text(widget.post["brand"]),
        
       // Image.network(widget.post["seller_logo"]),

        Text(widget.post["color"]),
        Text(widget.post["price"]),
      ],),
    );
  }
}
 */