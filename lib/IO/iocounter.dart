import "dart:io";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";

class IoCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[ CounterIo()],
    );
  }
}

class CounterIo extends StatefulWidget {
  CounterIo({Key key}) : super(key: key);
  @override
  _CounterIoState createState() => _CounterIoState();
}

class _CounterIoState extends State<CounterIo> {
  int _counter;
  Future<File> _getLocalFile() async {
    //获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    //将点击次数已字符串类型写入到文件中
    await (await _getLocalFile()).writeAsString("$_counter");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readCounter().then(
      (int value) {
        setState(() {
          _counter = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text("$_counter"),
        ),
        IconButton(
          onPressed: _incrementCounter,
          icon: Icon(Icons.add),
        )
      ],
    );
  }
}
