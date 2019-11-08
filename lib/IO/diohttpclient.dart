import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import "package:dio/dio.dart";

Dio dio = Dio();

class DioHttpClient extends StatefulWidget {
  @override
  _DioHttpClientState createState() => _DioHttpClientState();
}

class _DioHttpClientState extends State<DioHttpClient> {
  var _res;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            button(
              text: "get请求",
              callback: () async {
                Response response = await dio.get(
                    "https://saas2-portal.hseduyun.net/api/getWebSiteInfo?tenantId=002&organizationId=541");
                setState(() {
                  _res = response.data.toString();
                });
              },
            ),
            button(
                text: "GET使用query参数对象传递",
                callback: () async {
                  // Response response = await dio.get(
                  //     "https://saas2-portal.hseduyun.net/api/getWebSiteInfo",
                  //     queryParameters: {
                  //       "tenantId": 002,
                  //       "organizationId": 541
                  //     });
                  HttpClient httpClient = new HttpClient();
                  try {
                    HttpClientRequest request = await httpClient.getUrl(
                      Uri(
                        scheme: "https",
                        host: "saas2-portal.hseduyun.net",
                        path: "/api/getWebSiteInfo",
                        queryParameters: {
                          "tenantId": "002",
                          "organizationId": "541"
                        },
                      ),
                    );
                    HttpClientResponse response = await request.close();
                    print(request.uri);
                     var res = await response.transform(utf8.decoder).join();
                    setState(() {
                      _res = res;
                    });
                  } catch (e) {
                    print("请求失败$e");
                  } finally {
                    httpClient.close();
                  }
                }),
            Text("$_res")
          ],
        ),
      ),
    );
  }

  Widget button({text, @required callback}) {
    return RaisedButton(
      child: Text("$text"),
      onPressed: callback,
    );
  }
}
