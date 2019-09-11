# flutter_book_dom
flutter实战书
## 修改国内镜像
将Google()、jcenter()修改成  
maven { url 'https://maven.aliyun.com/repository/google' }  
maven { url 'https://maven.aliyun.com/repository/jcenter' }  
maven { url 'http://maven.aliyun.com/nexus/content/groups/public'}  
## 进度条  
进度条与圆形进度条的尺寸是由父元素控制的，可以使用sizedbox、ConstrainedBox控制大小
## Form
TextEditingController是设置输入框的controller  
TextEditingController _username = new TextEditingController();  
FocusNode是设置TextField的focusnode是控制对输入框的功能进行操作，失去焦点  
FocusNode _usernamenode = new FocusNode();  
获取焦点  
FocusScope.of(context).requestFocus(_passwordnode);
* 输入框可以通过单类中的
```dart
    onchang(v){print(v)}/initstate中的controller.addListener((){print(controll.text)})  
```
* 从第三个元素开始选中后面的文字 
```dart 
    controller.selection = TextSelection(baseOfft:2//偏移两个字符,ectenetOffset:controller.text.length)  
```
使用FormField实现单选框/校验  
```dart
FormField(
    onSaved: (value){
        // userinfor.gender(value);
    },
    validator:(value){
        if(value!=null){
            Radionflag = true; 
        return null;
        }else{
        setState(() {
            Radionflag = false; 
        });
        }
    },
    builder: (field){
        return Column(
        children: <Widget>[
            Radio(
            groupValue:field.value,
            value:1,
            onChanged: (newvalue){
                field.didChange(newvalue);
            },
            ),
            Radio(
            groupValue:field.value,
            value:2,
            onChanged: (newvalue){
                field.didChange(newvalue);
            },
            ),
            Radio(
            groupValue:field.value,
            value: 3,
            onChanged: (newvalue){
                field.didChange(newvalue);
            },
            ),
            Offstage(
            child: Text("单选为必选项"),
            offstage:Radionflag ,
            )
        ],
        );
    },
),
```
## 布局类
* Flex  
>使用direction:Axis.vertical纵向的需要一个确定的高度 例如使用container作为父容器  
* Stack  
>需要在一个固定的容器里面
* Tranform  
>Tranform的变换在渲染阶段，所以占用空间的大小和位置是不变的，会产生文字重叠的情况  
>使用RotateBox,RotateBox的变换在layout阶段，会影响大小和位置
* Scaffold/TabBar/底部导航
>实现了简单的一个有TabBar、bottomAppBar、TabBarView、AppBar小页面  
>[查找ScaffoldBox](https://github.com/lyx04/flutter_book_dom/blob/master/lib/container.dart)
* 下划线组件  
>Divider();  
* 滚动组件（可监控距离）  
>[监控滚动距离](https://github.com/lyx04/flutter_book_dom/blob/master/lib/scroll.dart)中的ListViewBox组件  
>每个滚动组件之前都要加Scrollbar增加滚动条  
>父组件写成NotificationListener可以实时监控到滚动的距离、总体列表的距离,**比ListView中的Controller获取到的信息要多**
* widget生命周期  
>initState > didChangeDependencies > build > (热重载后)reassemble > didupdateWidget > build > (移除节点之后)reassemble > deactive > dispose  
>initState:当widget第一次插入到widget树时会被调用  
>didChangeDependencies:当state对象的依赖发生变化时被调用  
>build:构建widget树 会在**initState/didUpdateWidget/setState/didChangeDependencies之后**被调用  
>reassemble:为开发调试而提供  
>didUpdateWidget:widget重构时,flutter framework会调用widget.canUpdate(true-调用,false-不调用)检测同一位置的节点  
>deactivate:当state对象从树中被移除时  
>dispose:在deactivate后没有重新插入树中就会被调用  
* 获取state对象的方法  
>Scaffold.of(context)  
>static GlobalKay<XXXState> _globalkey = GlobalKey()**将组件的key:_globalkey** 获取state对象的方法:_globalkey.currentState/获取widget对象:_globalkey.currentWidget
* InheritedWidget
>InheritedWidget中of方法中context的方法  
>1. context.inheritFromWidgetOfExactType(ShareDataWidget);调用的时候会触发子组件的didChangeDependencies的方法    
>2. context.ancestorInheritedElementForWidgetOfExactType(Widget).widget;不会触发子组件的didChangeDependencies的方法  
* Color  
> color.computeLuminance**获取颜色0-1的值颜色越大颜色越浅**  
* Dialog(弹框)  
> 使用**showDialog**对于**AlertDialog/SimpleDialog**进行显示  
> 使用**Dialog**可以在content中添加延迟加载模型的组件  
> 想要得到点击弹框列表中的值需要使用Navigator.of(context).pop(XXX)并且还需要在showDialog前使用await等待点击后值的返回  、
* 自定义弹框  
```dart
showGeneralDialog({
  @required BuildContext context,
  @required RoutePageBuilder pageBuilder, //构建对话框内部UI
  bool barrierDismissible, //点击遮罩是否关闭对话框
  String barrierLabel, // 语义化标签(用于读屏软件)
  Color barrierColor, // 遮罩颜色
  Duration transitionDuration, // 对话框打开/关闭的动画时长
  RouteTransitionsBuilder transitionBuilder, // 对话框打开/关闭的动画
})
```
