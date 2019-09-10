import 'dart:collection';
import 'dart:io';

import "package:flutter/material.dart";

class FeatureBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        WillPopBox(),
        InheritedWidgetTestRoute(),
        Shop(),
        NavBar(
          color: Colors.blue,
        ),
        FutureBuilderBox(),
        StreamBox(),
        AlertBox(),
        DialogState()
      ],
    ));
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
      onWillPop: () {
        // Future<bool>异步并返回布尔型可以使用Future.delayed/使用async await
        Future.delayed(Duration(milliseconds: 2000)).then((e) => true);
      },
      child: Container(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Scaffold(
                      appBar: AppBar(title: Text(":jj")),
                      body: WillPopScope(
                          onWillPop: () async {
                            if (_lastPressedAt == null ||
                                DateTime.now().difference(_lastPressedAt) >
                                    Duration(seconds: 1)) {
                              _lastPressedAt = DateTime.now();
                              return false;
                            }
                            return true;
                          },
                          child: Text("123")));
                }));
              },
              child: Text("点击"))),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);
  final int data;
  static ShareDataWidget of(BuildContext context) {
    // return context.inheritFromWidgetOfExactType(ShareDataWidget);
    return context
        .ancestorInheritedElementForWidgetOfExactType(ShareDataWidget)
        .widget;
  }

  @override
  bool updateShouldNotify(ShareDataWidget old) {
    return old.data != data;
  }
}

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() =>
      _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return ShareDataWidget(
      data: count,
      child: Column(
        children: <Widget>[
          TestWidget(),
          RaisedButton(
            child: Text("添加一个"),
            onPressed: () {
              setState(() {
                count++;
              });
            },
          )
        ],
      ),
    );
  }
}

class Provider<T> extends InheritedWidget {
  Provider({@required this.data, Widget child}) : super(child: child);
  final T data;

  @override
  bool updateShouldNotify(old) {
    return true;
  }
} //

class ChangeNotifier implements Listenable {
  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
  void notifyListeners() {
    //通知所有监听器，触发监听器回调
  }
}

Type _typeof<T>() => T;

class ChangeModel<T extends ChangeNotifier> extends StatefulWidget {
  ChangeModel({Key key, this.data, this.child});
  final T data;
  final Widget child;
  static T of<T>(BuildContext context) {
    final type = _typeof<Provider<T>>();
    final provider = context.inheritFromWidgetOfExactType(type) as Provider<T>;
    return provider.data;
  }

  @override
  _ChangeModelState<T> createState() => _ChangeModelState<T>();
}

class _ChangeModelState<T extends ChangeNotifier>
    extends State<ChangeModel<T>> {
  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeModel<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      oldWidget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.data.addListener(update);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(data: widget.data, child: widget.child);
  }
}

class Item {
  Item(this.price, this.count);
  double price;
  int count;
}

class CartModel extends ChangeNotifier {
  final List<Item> _list = [];
  //禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_list);
  double get totalPrice =>
      _list.fold(0, (value, item) => value + item.count * item.price);
  void add(Item item) {
    _list.add(item);
    notifyListeners();
  }
}

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ChangeModel<CartModel>(
            data: CartModel(),
            child: Column(
              children: <Widget>[
                Builder(
                  builder: (context) {
                    var cart = ChangeModel.of<CartModel>(context);
                    return Text("总价: ${cart.totalPrice}");
                  },
                ),
                Builder(
                  builder: (context) {
                    return RaisedButton(
                      child: Text("添加商品"),
                      onPressed: () {
                        ChangeModel.of<CartModel>(context).add(Item(20, 1));
                      },
                    );
                  },
                )
              ],
            )));
  }
}

class NavBar extends StatelessWidget {
  final Color color;
  NavBar({Key key, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color, boxShadow: [
          BoxShadow(blurRadius: 4.0, color: color, offset: Offset(0, 3))
        ]),
        width: double.infinity,
        height: 50.0,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ThemeRoute();
            }));
          },
          child: Text(
            "标题",
            style: TextStyle(
                color: color.computeLuminance() < 0.5
                    ? Colors.white
                    : Colors.black),
          ),
        ));
  }
}

class ThemeRoute extends StatefulWidget {
  @override
  _ThemeRouteState createState() => _ThemeRouteState();
}

class _ThemeRouteState extends State<ThemeRoute> {
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor,
        iconTheme: IconThemeData(color: _themeColor),
      ),
      child: Scaffold(
          appBar: AppBar(title: Text("主题测试")),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("颜色跟随主题")
                  ]),
              Theme(
                  data: themeData.copyWith(
                      iconTheme: IconThemeData(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Icon(Icons.airport_shuttle),
                      Text("  颜色固定黑色")
                    ],
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal;
              });
            },
          )),
    );
  }
}

Future<String> mockNetWorkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

class FutureBuilderBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
      future: mockNetWorkData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            // 请求成功，显示数据
            return Text("Contents: ${snapshot.data}");
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
    ));
  }
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}

//适用于websocket
class StreamBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: counter(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text("Error:${snapshot.error}");
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("没有Stream");
          case ConnectionState.waiting:
            return Text("等待数据");
          case ConnectionState.active:
            return Text("active:${snapshot.data}");
          case ConnectionState.done:
            return Text("stream关闭");
        }
        return null;
      },
    );
  }
}

Future alert() {
  return Future.delayed(Duration(seconds: 2), () => "fsdfsd");
}

class AlertBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: alert(),
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Column(
              children: <Widget>[
                Container(
                    child: AlertDialog(
                  title: Text("提示"),
                  content: Text("你确定要删除当前文件吗？"),
                  actions: <Widget>[
                    RaisedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("取消", style: TextStyle(color: Colors.white)),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("确认", style: TextStyle(color: Colors.white)),
                    )
                  ],
                )),
                Center(
                  child: RaisedButton(
                      onPressed: () async {
                        var dialog;
                        dialog = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("这是被等待出现的弹框"),
                                actions: <Widget>[
                                  RaisedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text("取消",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text("确认",
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              );
                            });
                        print(dialog);
                      },
                      child: Text("弹出弹框")),
                ),
                Center(
                    child: RaisedButton(
                        onPressed: () async {
                          var dialog;
                          dialog = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: Text("请选择语言"),
                                children: <Widget>[
                                  SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context, 1);
                                      },
                                      child: Text("中文")),
                                  SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context, 2);
                                      },
                                      child: Text("英文"))
                                ],
                              );
                            },
                          );
                          print(dialog);
                        },
                        child: Text("弹出对话框"))),
                Center(
                  child: RaisedButton(
                      onPressed: () {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("列表"),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text("1"),
                                      ),
                                      ListTile(
                                        title: Text("1"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text("弹出一个带有列表的弹出框")),
                ),
                Center(
                    child: RaisedButton(
                  onPressed: () async {
                    var index = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("延迟加载列表"),
                            content: ListView(
                              children: <Widget>[
                                ListTile(
                                  title: Text("fjsdk"),
                                  onTap: () => Navigator.of(context).pop(1),
                                ),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                                ListTile(title: Text("fjsdk")),
                              ],
                            ),
                          );
                        });
                    print(index);
                  },
                  child: Text("通过dialog弹出一个延迟加载的列表页"),
                ))
              ],
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class DialogState extends StatefulWidget {
  @override
  _DialogStateState createState() => _DialogStateState();
}

class _DialogStateState extends State<DialogState> {
  bool dialogstate = false;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("带有状态的弹框"),
      onPressed: () async{
        var delect =  await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("提示"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("取消"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("确定"),
                    onPressed: () {
                      Navigator.of(context).pop(dialogstate);
                    },
                  )
                ],
                content: Column(
                  children: <Widget>[
                    Text("您确定要删除当前文件么？"),
                   Row(
                     children: <Widget>[
                       Text("同时删除子目录"),
                       UserCheckbox(
                         value: dialogstate,
                         onChange: (v){
                            setState(() {
                             dialogstate = v; 
                            });
                         },
                       )
                     ],
                   )
                  ],
                ),
              );
            });
            print("状态是${delect}");
      },
    );
  }
}

class UserCheckbox extends StatefulWidget {
  UserCheckbox({
    Key key,
    this.value,
    @required this.onChange
  });
  final bool value;
  final ValueChanged<bool> onChange;
  @override
  _UserCheckboxState createState() => _UserCheckboxState();
}

class _UserCheckboxState extends State<UserCheckbox> {
  bool value;
  @override
  void initState() {
    // TODO: implement initState
    value = widget.value;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v){
        widget.onChange(v);
        setState(() {
         value = v;
        });
      },
    );
  }
}
