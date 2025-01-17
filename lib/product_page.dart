import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.barcode});

  final String barcode;
  Future<List<dynamic>> fetchPosts() async {
    List posts = [];
    var response = await Dio().get(
        "https://frozen-shore-19761.herokuapp.com/api/v1/products/$barcode");
    posts = response.data;
    print(response.data);
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchPosts(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
          case ConnectionState.waiting:
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return ScreenOne(snapshot.data);
        }
        return null; // unreachable
      },
    );
  }
}

class ScreenOne extends StatelessWidget {
  final List<dynamic> posts;

  ScreenOne(this.posts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Page"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, i) {
          return PostView(posts[i]);
        },
      ),
    );
  }
}

class PostView extends StatefulWidget {
  final Map<String, dynamic> post;

  PostView(this.post, {String barcode});

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            widget.post["seller"],
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
          ),
          Image.network(widget.post["image_url"]),
          Text(
            widget.post["brand"],
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            widget.post["color"],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
          ),
          Text(
            widget.post["price"],
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
          ),
          Text(""),
          Text(
            "----------------------------------------------------------",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
          ),
          Text(""),
        ],
      ),
    );
  }
}
