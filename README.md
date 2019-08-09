# flutter_book_dom
flutter实战书
## 修改国内镜像
将Google()、jcenter()修改成  
maven { url 'https://maven.aliyun.com/repository/google' }  
maven { url 'https://maven.aliyun.com/repository/jcenter' }  
maven { url 'http://maven.aliyun.com/nexus/content/groups/public'}  
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