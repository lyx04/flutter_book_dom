import "package:flutter/material.dart";

class DataShare extends InheritedWidget {
  DataShare({
    Key key,
    @required this.data,
    Widget child,
  }) : super(child: child);
  final int data;
  static DataShare of(BuildContext context) {
    print(context);
    // 定义一个便捷方法，方便子树中的Widget获取共享数据
    return context.inheritFromWidgetOfExactType(DataShare);
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(DataShare oldWidget) {
    // print("-------------------------------");
    // print(oldWidget.data);
    // print(data);
    // print("-------------------------------");
    //如果返回true，则子树中依赖（build函数中有调用）本Widget的子Widget的State.didChangeDependencies会被调用
    return oldWidget.data != data;
  }
}

class Test1Widget extends StatefulWidget {
  @override
  _Test1WidgetState createState() => _Test1WidgetState();
}

class _Test1WidgetState extends State<Test1Widget> {
  int count = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("我在Test中被调用了");
  }

  @override
  Widget build(BuildContext context) {
    return DataShare(
      data: count,
      child: Column(
        children: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return Text(
                DataShare.of(context).data.toString(),
              );
            },
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: Text("自增1"),
          )
        ],
      ),
    );
  }
}

class ShopInheritedWidget extends InheritedWidget {
  ShopInheritedWidget({Key key, this.list, Widget child}) : super(child: child);
  final List list;
  @override
  bool updateShouldNotify(ShopInheritedWidget oldWidget) {
    print(list);
    return true;
  }

  static ShopInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShopInheritedWidget);
  }
}

class ShopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return ShopList();
              }),
            );
          },
          child: Text("开始"),
        ),
      ),
    );
  }
}

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  List shoplist = [];
  List shopList = [
    {"name": "card", "money": "10"},
    {"name": "fsdf", "money": "30"},
    {"name": "gsdf", "money": "20"},
    {"name": "cvxb", "money": "40"},
    {"name": "erw", "money": "50"},
    {"name": "asdf", "money": "60"},
    {"name": "zcxxv", "money": "70"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ShopCard();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: ShopInheritedWidget(
        list: shoplist,
        child: ListView(
          children: shopList.map((e) {
            var name = e['name'];
            return ListTile(
              title: Text("$name"),
              onTap: () {
                shoplist.add(e);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ShopCard extends StatefulWidget {
  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车详情"),
      ),
      body: ShopInheritedWidget(
        child: Column(
          children: <Widget>[
            Builder(
              builder: (BuildContext context1) {
                print(context1);
                print("--------------------------------------------");
                print(ShopInheritedWidget.of(context1).list);
                return Text("fsd");
                // return Expanded(
                //   child: ListView(
                //     children: ShopInheritedWidget.of(context1).list.map((e) {
                //       var name = e['name'];
                //       return ListTile(
                //         title: Text("$name"),
                //       );
                //     }).toList(),
                //   ),
                // );
              },
            ),
            // Builder(
            //   builder: (BuildContext context) {
            //     var money = 0;
            //     ShopInheritedWidget.of(context).list.forEach((e) {
            //       money += int.parse(e["money"]);
            //     });
            //     return Expanded(child: Text("$money"));
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
