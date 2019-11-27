import "package:flutter/material.dart";

class CommonInher<T> extends InheritedWidget {
  CommonInher({@required this.data, Widget child}) : super(child: child);

  final T data; //共享属性为泛型

  @override
  bool updateShouldNotify(CommonInher<T> oldWidget) {
    return true;
  }
}

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
