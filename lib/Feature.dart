import "package:flutter/material.dart";

class FeatureBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child:ListView(
        shrinkWrap: true,
        children: <Widget>[
WillPopBox()
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
                      return false;
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