import "package:flutter/material.dart";
import "package:web_socket_channel/io.dart";

class WebSockets extends StatefulWidget {
  @override
  _WebSocketsState createState() => _WebSocketsState();
}

class _WebSocketsState extends State<WebSockets> {
  TextEditingController textController = TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect("ws://echo.websocket.org");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    channel.sink.close();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          child:TextFormField(
            controller: textController,
            decoration: InputDecoration(labelText: "message"),
          )
        ),
        StreamBuilder(
          stream: channel.stream,
          builder: (BuildContext context,snapshot){
            if(snapshot.hasError){
              _text ="网络不通";
            }else if(snapshot.hasData){
              _text = snapshot.data;
            }
            return Padding(
              padding: EdgeInsets.all(10.0),
              child:Text("$_text")
            );
          },
        ),
        RaisedButton(
          onPressed: sendMessage,
          child: Text("发送请求"),
        )
      ],
    );
  }
  void sendMessage(){
    if(textController.text.isNotEmpty){
      channel.sink.add(textController.text);
    }
  }
}
