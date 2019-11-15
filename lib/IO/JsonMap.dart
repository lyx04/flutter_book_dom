import 'dart:convert';

import "package:flutter/material.dart";

class JsonandMap extends StatefulWidget {
  @override
  _JsonandMapState createState() => _JsonandMapState();
}

class _JsonandMapState extends State<JsonandMap> {
  String jsonStr = '[{"name":"jsec"},{"name":"ore"}]';
  List items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(JsonandMap oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    items = json.decode(jsonStr);
    var user = new User.fromJson(items[0]);
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("安排"),
    );
  }
}

class User {
  final String name;
  final String email;
  User(this.email, this.name);

  User.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"];
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"name": name, "email": email};
}
