import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'member.dart';
import 'strings.dart';

class GHFlutter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GHFlutterState();
  }
}

class GHFlutterState extends State<GHFlutter> {
  var _githubTeamMembers = <Member>[];
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
      final membersJSON = json.decode(response.body);
      
      for (var memberJSON in membersJSON) {
        final member = Member(memberJSON["login"], memberJSON["avatar_url"]);
        _githubTeamMembers.add(member);
      }
    });
  }

  Widget _buildRow(int i) {
    return new Padding(
      padding: EdgeInsets.all(16.0),
      child: ListTile(
        title: new Text(
          "${_githubTeamMembers[i].login}",
          style: _biggerFontSize,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: NetworkImage(_githubTeamMembers[i].avatarUrl),
        ),
      ),
    );
  }
}