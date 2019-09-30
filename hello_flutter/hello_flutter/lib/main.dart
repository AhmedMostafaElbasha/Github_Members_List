import 'package:flutter/material.dart';
import 'strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.appTitle,
      home: GHFlutter(),
    );
  }
}

class GHFlutterState extends State<GHFlutter> {
  var _githubTeamMembers = [];
  final _biggerFontSize = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(Strings.appTitle),
      ),
      body: ListView.builder(
        itemCount: _githubTeamMembers.length * 2,
        itemBuilder: (BuildContext context, int position) {
          if (position.isOdd) {
            return Divider();
          }
          final index = position ~/ 2;
          return _buildRow(index);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    var dataUrl = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(dataUrl);
    setState(() {
      _githubTeamMembers = json.decode(response.body);
    });
  }

  Widget _buildRow(int i) {
    return new Padding(
      padding: EdgeInsets.all(16.0),
      child: ListTile(
        title: new Text(
          "${_githubTeamMembers[i]["login"]}",
          style: _biggerFontSize,
        ),
      ),
    );
  }
}

class GHFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GHFlutterState();
  }
}
