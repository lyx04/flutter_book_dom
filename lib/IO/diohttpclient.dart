import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
import "package:dio/dio.dart";
import 'package:path_provider/path_provider.dart';

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
              },
            ),
            button(
                text: "dioPost请求",
                callback: () async {
                  Response response = await dio.post(
                      "https://newedu.yceduyun.com/newEditionHome/getInfoByDomain");
                  setState(() {
                    _res = response.data.toString();
                  });
                }),
            button(
              text: "自己写的post请求",
              callback: () async {
                HttpClient httpClient = new HttpClient();
                HttpClientRequest request = await httpClient.postUrl(
                  Uri.parse(
                      "https://newedu.yceduyun.com/newEditionHome/getInfoByDomain"),
                );
                HttpClientResponse response = await request.close();
                var text = await response.transform(utf8.decoder).join();
                setState(() {
                  _res = text;
                });
              },
            ),
            button(
                text: "下载文件(有问题)",
                callback: () async {
                  String file = (await getApplicationDocumentsDirectory()).path;
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$file"),
                    ),
                  );

                  new Directory('dir/subdir').create(recursive: true)
                      // The created directory is returned as a Future.
                      .then((Directory directory) {
                    print(directory.path);
                  });
                  // Response response = await dio.download(
                  //     "http://m.ityyedu.com/grain/testItem/exportWordTestItem?sampleId=165&sessionid=27f02246-d774-49e9-a208-6fbe4f3567b7",
                  //     file);
                  //     print(response);
                }),
            button(
                text: "发送FormData",
                callback: () async {
                  FormData formData =
                      new FormData.fromMap({"name": "wendux", "age": 25});
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
