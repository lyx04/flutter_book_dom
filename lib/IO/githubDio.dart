import "package:flutter/material.dart";
import "package:dio/dio.dart";

class FutereBuilderRoute extends StatefulWidget {
  @override
  _FutereBuilderRouteState createState() => _FutereBuilderRouteState();
}

class _FutereBuilderRouteState extends State<FutereBuilderRoute> {
  Dio dio = new Dio();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          //请求成功
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            Response response = asyncSnapshot.data;
            if (asyncSnapshot.hasError) {
              return Text(asyncSnapshot.error.toString());
            }
            return ListView(
              children: response.data
                  .map<Widget>(
                    (e) => ListTile(
                      title: Text(e["full_name"]),
                    ),
                  )
                  .toList(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
