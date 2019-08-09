import "package:flutter/material.dart";
import "dart:math" as math;

class ContainerBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldBox();
    // ListView(
    //   children: <Widget>[
    //     PaddingBox(),
    //     ConstrainBox(),
    //     SizeBox(),
    //     TwoparentBox(),
    //     DecoratBox(),
    //     TransFormBox(),
    //     Translate(),
    //     Rotate(),
    //     Scale(),
    // ContaineBox()
    //     RotateBox(),
    //   ],
    // );
  }
}

class PaddingBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          child: Text("padding"),
        ));
  }
}

class ConstrainBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      //给子元素做宽高限制
      constraints: BoxConstraints(
          minWidth: double.infinity, minHeight: 50.0, maxHeight: 50.0),
      child: Container(
          height: 123.0,
          color: Colors.red,
          child: Text("这是可以限制大小的constrainedBox")),
    );
  }
}

class SizeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 10.0,
        child: Container(
          width: 20.0,
          color: Colors.indigo,
          child: Text("这是sizedBox"),
        ));
  }
}

class TwoparentBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: 100.0,
      ),
      child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: 200.0, maxWidth: double.infinity),
          child: Container(
              width: double.infinity,
              height: 300.0,
              color: Colors.red,
              child: Text("我的宽高,谁的大，我找谁的"))),
    );
  }
}

class DecoratBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.orange[700]]),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ],
        ),
        child: Container(height: 50.0, child: Text("这是decoratedBox")));
  }
}

class TransFormBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.skewY(0.3),
        child: Container(color: Colors.deepOrange, child: Text("4d旋转")));
  }
}

class Translate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child:
            Transform.translate(offset: Offset(20.0, -5.0), child: Text("位移")));
  }
}

class Rotate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Transform.rotate(angle: 0, child: Text("旋转")));
  }
}

class Scale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Transform.scale(scale: 1.5, child: Text("放大")));
  }
}

class RotateBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RotatedBox(quarterTurns: 1, child: Text("rotate")),
        Text(
          "你好",
          style: TextStyle(color: Colors.green, fontSize: 18.0),
        )
      ],
    );
  }
}

class ContaineBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationZ(.2),
      child: Container(
        width: 300.0,
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
        height: 90.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(1.0, 1.0), blurRadius: 4.0)
          ],
          gradient: RadialGradient(
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .98),
        ),
        child: Text("5.20"),
      ),
    );
  }
}

class ScaffoldBox extends StatefulWidget {
  @override
  _ScaffoldBoxState createState() => _ScaffoldBoxState();
}

class _ScaffoldBoxState extends State<ScaffoldBox>
    with SingleTickerProviderStateMixin {
  num containerindex = 0;
  List<Widget> bodyList = [];
  TabController tab;
  List tabList = [
    "新闻",
    "历史",
    "图片",
  ];
  num colorActive = 0;
  @override
  void initState() {
    bodyList
      ..add(BodyContainer(title: "home"))
      ..add(BodyContainer(
        title: "business",
      ))
      ..add(BodyContainer(title: "School"));
    tab =
        new TabController(initialIndex: 0, length: tabList.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("App Name"),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.share))
        ],
        leading: Builder(
          builder: (ctx) {
            return IconButton(
              icon: Icon(Icons.dashboard),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
            );
          },
        ),
        bottom: TabBar(
            controller: tab, tabs: tabList.map((e) => Tab(text: e)).toList()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, //显示页面悬浮按钮的位置
      // body:bodyList[containerindex],//此处为底部导航栏所用
      body: TabBarView(
        controller: tab,
        children: tabList.map((e) {
          return Container(
              child: Text(
            e,
            textScaleFactor: 5,
          ));
        }).toList(),
      ),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              IconButton(
                color: colorActive == 0 ? Colors.black : Colors.grey,
                onPressed: () {
                  tab.animateTo(0);
                  setState(() {
                    colorActive = 0;
                  });
                },
                icon: Icon(Icons.home),
              ),
              IconButton(
                  color: colorActive == 2 ? Colors.black : Colors.grey,
                  onPressed: () {
                    tab.animateTo(2);
                    setState(() {
                      colorActive = 2;
                    });
                  },
                  icon: Icon(Icons.business))
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )),
      // bottomNavigationBar: BottomNavigationBar(//使用bottomNavigationBar与floatingActionButtonLocation的按钮不能做成底部导航嵌套的样子，需要使用BottomAppBar
      //   onTap: (index) {
      //     setState(() {
      //       containerindex = index;
      //     });
      //   },
      //   currentIndex: containerindex,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text("HOME"),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       title: Text("Business"),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       title: Text("School"),
      //     )
      //   ],
      // )
    );
  }
}

class BodyContainer extends StatelessWidget {
  BodyContainer({Key key, this.title}) : super(key: key);
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("$title"));
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 38.0),
              child: Row(
                children: <Widget>[
                  ClipOval(
                      child: Image.network(
                    "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=3757916566,3108098082&fm=58&bpow=512&bpoh=512",
                    width: 50,
                  )),
                  Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Text("用户名"))
                ],
              )),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text("Add account"),
                  onTap: () {},
                ),
                ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Manage account"))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
