import 'package:flutter/material.dart';

void main() => runApp(GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "GHFlutter",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("GHFlutter"),
        ),
        body: new Center(
          child: new Text("GHFlutter"),
        ),
      ),
    );
  }
  
}