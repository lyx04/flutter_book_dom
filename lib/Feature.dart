import "package:flutter/material.dart";

class FeatureBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child:ListView(
        shrinkWrap: true,
        children: <Widget>[
WillPopBox(),
InheritedWidgetTestRoute()
        ],
      )
    );
  }
}

class WillPopBox extends StatefulWidget {
  @override
  _WillPopBoxState createState() => _WillPopBoxState();
}

class _WillPopBoxState extends State<WillPopBox> {
  DateTime _lastPressedAt;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        // Future<bool>异步并返回布尔型可以使用Future.delayed/使用async await
        Future.delayed(Duration(milliseconds: 2000)).then((e)=>true);
      },
      child: Container(
        child:GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context){
                return Scaffold(
                  appBar: AppBar(
                    title:Text(":jj")
                  ),
                  body:WillPopScope(
                    onWillPop: ()async{
                      if(_lastPressedAt == null|| DateTime.now().difference(_lastPressedAt)>Duration(seconds: 1)){
                        _lastPressedAt = DateTime.now();
                        return false;
                      }
                      return true;
                    },
                    child:Text("123")
                  )
                );
              }
            ));
          },
          child:Text("点击")
        )
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget{
  ShareDataWidget({
    @required this.data,
    Widget child
  }):super(child:child);
  final int data;
  static ShareDataWidget of(BuildContext context){
    return context.inheritFromWidgetOfExactType(ShareDataWidget);
  }
  @override
  bool updateShouldNotify(ShareDataWidget old){
    return old.data !=data;
  }
}

class _TextWidget extends StatefulWidget {
  @override
  __TextWidgetState createState() => __TextWidgetState();
}

class __TextWidgetState extends State<_TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("它会在“依赖”发生变化时被Flutter Framework调用");
  }
}
class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() => _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child:ShareDataWidget(
        data:count,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:const EdgeInsets.all(10.0),
              child:_TextWidget()
            ),
            RaisedButton(
              child:Text("点击加以"),
              onPressed: (){
                setState(() {
                 count++; 
                });
              },
            )
          ],
        )
      )
    );
  }
}
