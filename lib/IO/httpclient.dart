import 'dart:convert';

import "package:flutter/material.dart";
import "dart:io";

class HttpclientRoute extends StatefulWidget {
  @override
  _HttpclientRouteState createState() => _HttpclientRouteState();
}

class _HttpclientRouteState extends State<HttpclientRoute> {
  bool loading = false;
  String txt = "";
  HttpClient _httpClient = new HttpClient();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("获取百度"),
              onPressed: loading
                  ? null
                  : () async {
                      setState(() {
                        loading = true;
                        txt = "正在请求";
                      });
                      try {
                        HttpClientRequest request = await _httpClient
                            .getUrl(Uri.parse("https://www.baidu.com"));
                        // request.headers.add("user-agent","Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                        HttpClientResponse response = await request.close();
                        txt = await response.transform(utf8.decoder).join();
                        print(response.headers);
                        request.close();
                      } catch (e) {
                        txt = "请求失败：$e";
                      } finally {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
            ),
            Expanded(
              child:Scrollbar(
              child: SingleChildScrollView(
                child: Container(
                  child: Text(txt),
                ),
              ),
            )
            )
          ],
        ));
  }
}
