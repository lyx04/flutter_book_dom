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
            // Image.network("https://pics7.baidu.com/feed/43a7d933c895d143d999588f497236075baf0732.jpeg?token=4c08e6b9f588212ab501a2b07996bab4&s=B19A71943401DAEF8AB7FEC10300F0A9",width: 100.0,height: 100.0,),
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
                        // _httpClient.connectionTimeout = Duration( minutes: 2);
                        HttpClientRequest request = await _httpClient
                            .getUrl(Uri.parse("https://www.baidu.com"));
                            // .getUrl(Uri.parse("https://news-at.zhihu.com/api/4/news/latest"));
                        request.headers.add("user-agent","Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1");
                        HttpClientResponse response = await request.close();
                        txt = await response.transform(utf8.decoder).join();
                        print(response.headers);
                        request.close();
                      } catch (e) {
                        print(e);
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
