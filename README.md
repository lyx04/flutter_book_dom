# flutter_book_dom
flutter实战书10.4/5暂且跳过  
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
UnconstrainedBox取消父的宽高限制  
* RotatedBox  
> 可以对子组件进行旋转，变化阶段在layout，会影响子组件的位置和大小
* InkWell  
> 在手指按下会有涟漪效果  
* DecoratedBox  
> 装饰容器  
> decoration：代表将要绘制的装饰，它的类型为Decoration。Decoration是一个抽象类，它定义了一个接口 createBoxPainter()，子类的主要职责是需要通过实现它来创建一个画笔，该画笔用于绘制装饰。
position：此属性决定在哪里绘制Decoration，它接收DecorationPosition的枚举类型，该枚举类有两个值：
background：在子组件之后绘制，即背景装饰。
foreground：在子组件之上绘制，即前景。  
```dart
const DecoratedBox({
  Decoration decoration,
  DecorationPosition position = DecorationPosition.background,
  Widget child
})
```  
* Flex  
>使用direction:Axis.vertical纵向的需要一个确定的高度 例如使用container作为父容器  
* Stack  
>需要在一个固定的容器里面
>positioned必须在stack中
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
> 想要得到点击弹框列表中的值需要使用Navigator.of(context).pop(XXX)并且还需要在showDialog前使用await等待点击后值的返回  
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
## 第八章Event  
* Listener  
> 在事件冲突时可以使用listener直接识别原始指针事件
> brhavior 决定子组件如何响应命中测试  
1. deferToChild 只会点击到子组件才会有用并且不是透明的  
2. opaque 效果可以作用于整个widget  
3. translucent 顶部的组件与底部组件都可以接收到 顶部组件的空白地方可以"点透"  
> 忽略PointerEvent  
1. AbsorbPointer他之后的子树不接受指针事件  
2. IgnorePointer不允许参与命中测试  
> TextSpan中使用事件  
1. 引入"package:flutter/gestures.dart";  
2. 在TextSpan中使用recognizer 
```dart
    recognizer: _tapGestureRecognizer..onTap = (){
        setState(() {
            _toggle = !_toggle; 
        });
    }
```  
3. 一定要释放TapGestureRecognizer的内存**暂时不知道为什么要释放内存**
* NotificationListener  
> 可以定义NotificationListener的监控类型  
```dart
//ScrollEndNotification滚动停止时触发
NotificationListener<ScrollEndNotification>(
    onNotification: (notification) {
        print(notification);
        // switch (notification.runtimeType) {
        //   case ScrollStartNotification:
        //     print("开始滚动");
        //     break;
        //   case ScrollUpdateNotification:
        //     print("正在滚动");
        //     break;
        //   case ScrollEndNotification:
        //     print("滚动停止");
        //     break;
        //   case OverscrollNotification:
        //     print("滚动到边界");
        //     break;
        // }
    })
```  
1. 假设NotificationListener嵌套，为了使子组件阻止冒泡,在onNotification中需要return true否则return false父组件NotificationListener的onNotification可以接收到通知  
## 动画 **需要重新学习尤其9.7**  
* Animation保存动画状态和插值的  
> Animation<double>/Animation<Color>/Animation<Size> 通过Animation对象的value属性获取动画的当前状态值 
> addListener() 给Animation添加帧监听器，每一帧都会被调用/addStatusListener()  添加"动画状态改变"监听器,动画开始(forward)、结束(completed)、正向(forward)、反向(reverse)时会调用状态改变的监听器  
> 通常会将SingleTickerProviderStateMixin添加在state定义中  
* Curve动画过程  
> CurvedAnimation可以通过包装AnimationController与Curve结合生成一个新的动画对象  
```dart
    final CurvedAnimation curve = new CurvedAnimation(parent: controller,curve:Curves.easeIn);
```   
> AnimationController用于控制动画  
```dart
    final AnimationController controller = new AnimationController(duration:const Duration(milliseconds:2000),vsync:this)
    //lowerBound与upperBound是生成的区间 
    final AnimationController controller = new AnimationController(duration:const Duration(milliseconds:2000),lowerBound:10.0,upperBound:20.0,vsync:this)
```  
> 构建一个控制器  
```dart
    final AnimationController controller = new AnimationController(duration:const Duration(milliseconds:2000),vsync:this)
```  
> 构建一个曲线  
```dart
    final Animation curve = new CurvedAnimation(parent:controller,curve:Curves.easeOut)
```  
> 构建一个tween  
```dart
    Animation<double> alpha = new Tween(begin:0;end:255).animate(controller)
```  
* 页面之间的动画跳转 MaterialPageRoute是与平台风格一致的动画/CupertinoPageRoute是Ios的动画风格/PageRouteBuilder是自定义动画风格  
> 所有的路由动画都可以继承PageRoute来实现  
> FadeTransition淡入淡出动画/CurvedAnimation曲线动画  
* AnimatedSwitcher  
```dart
AnimatedSwitcher({
  Key key,
  this.child,
  @required this.duration, // 新child显示动画时长
  this.reverseDuration,// 旧child隐藏的动画时长
  this.switchInCurve = Curves.linear, // 新child显示的动画曲线
  this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
  this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder, // 动画构建器
  this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器
})
```  
> 一个子元素新旧值之间的切换(AnimatedSwitcher)AnimatedSwitcher的新旧child，如果类型相同，则Key必须不相等()。  
```dart
AnimatedSwitcher(
    duration: Duration(milliseconds: 5000),
    transitionBuilder: (Widget child, Animation<double> animtion) {
        return FadeTransition(
        child:child,
        opacity:animtion
        );
    },
    child: Text("$_count",
        key: ValueKey<int>(_count),
        style: Theme.of(context).textTheme.display1
    )
)
```  
* IO  
>App目录(PathProvider提供访问设备文件)Dart io的库操作文件的api非常丰富  
1. 使用getTemporaryDirectory()获取苹果NSTemporaryDirectory()/android(getCacheDir())的**临时目录**  
2. 使用getApplicationDocumentsDirectory()获取苹果NSDocumentDirectory/android(AppData)的**文档目录**  
3. 使用getExternalStorageDirectory()获取android使用getExternalStorageDirectory/苹果会抛出UnsupportedError异常**外部存储目录**  
* 发送http请求  
1. 创建一个HttpClient(HttpClient httpClient = new HttpClient();)  
2. 打开http连接，设置请求头  
```dart
    HttpClientRequest request = await httpClient.getUrl(uri)/httpClient.post()/httpClient.delete;
    Uri uri = Uri(scheme:"https",host:"",queryParameters:{xx:xx,yy:yy});
    request.headers.add("user-agent","test")//设置请求header
    ////////////////////////////////////////////////////////////////////////////
    //如果是post或者put方法可以
    String payload = ""
    request.add(utf8.encode(payload));
```  
3. 等待链接服务器  
```dart
    HttpClientResponse response = await request.cloes();
```  
4. 读取响应内容(通过读取响应流来获取服务器返回的数据，读取时可以设置编码格式)  
```dart
    responseBody = await response.transform(utf8.decoder).join();
```  
5. 关闭请求(httpclient.close())  
* JSON-Model(11.7)  
* Element与widget的关系  
1. Flutter的树是一个个独立的Element节点构成，组件最终的Layout、**渲染是通过RenderObject完成，根据Widget生成Element、创建响应的RenderObject并关联到Element.renderObject属性上，最后通过RenderObject完成布局排列**  
2. flutter UI系统包含三棵树、**Widget树、element树、渲染树** 依赖关系为element树根据Widget树生成、渲染树依赖于element树