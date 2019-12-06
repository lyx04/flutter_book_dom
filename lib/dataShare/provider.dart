import 'dart:collection';

import "package:flutter/material.dart";

//数据存储组件
class CommonInher<T> extends InheritedWidget {
  CommonInher({@required this.data, Widget child}) : super(child: child);

  final T data; //共享属性为泛型

  @override
  bool updateShouldNotify(CommonInher<T> oldWidget) {
    //返回true才可以触发子组件的didchangedependencies
    return true;
  }
}

//发布者-订阅者的方法集合
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

Type _typeOf<T>() => T;

class CHangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  @override
  _CHangeNotifierProvider<T> createState() => _CHangeNotifierProvider<T>();
  CHangeNotifierProvider({Key key, this.data, this.child});

  final Widget child;
  final T data;

  static T of<T>(BuildContext context) {
    final type = _typeOf<CommonInher<T>>();
    print(type);
    final provider =
        context.inheritFromWidgetOfExactType(type) as CommonInher<T>;
    print(provider);
    return provider.data;
  }
}

class _CHangeNotifierProvider<T extends ChangeNotifier>
    extends State<CHangeNotifierProvider<T>> {
  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(CHangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    print(widget.data);
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonInher<T>(data: widget.data, child: widget.child);
  }
}

class Item {
  Item(this.price, this.count);
  double price; //商品单击
  int count; //商品份数
}

class CartModel extends ChangeNotifier {
  //用于保存购物车中的商品列表
  final List<Item> _items = [];
  //禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(items);

  //购车的商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class ProviderShop extends StatefulWidget {
  @override
  _ProviderShopState createState() => _ProviderShopState();
}

class _ProviderShopState extends State<ProviderShop> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CHangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(
          builder: (BuildContext context) {
            return Column(children: <Widget>[
              Builder(
                builder: (BuildContext context) {
                  var cart = CHangeNotifierProvider.of<CartModel>(context);
                  return Text("总价:${cart.totalPrice}");
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return RaisedButton(
                    child:Text("添加商品"),
                    onPressed: () {
                      CHangeNotifierProvider.of<CartModel>(context).add(
                        Item(20.0, 1),
                      );
                    },
                  );
                },
              ),
            ]);
          },
        ),
      ),
    );
  }
}
