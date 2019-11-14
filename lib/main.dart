import "package:flutter/material.dart";
import "./layout.dart";
import "./container.dart";
import "./scroll.dart";
import "./Feature.dart";
import "./event.dart";
import "Observer/publisher.dart";
import "NotificationBox.dart";
import "animation/animation.dart";
import "animation/pageAnimation.dart";
import "animation/CommonAnimation.dart";
import "animation/TransitionAnimation.dart";
import "customWidget/customIndex.dart";
import "IO/iocounter.dart";
import 'IO/httpclient.dart';
import "IO/diohttpclient.dart";
import "IO/githubDio.dart";
import "IO/websockets.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: WebSockets()));
  }
}

class BaseBox extends StatefulWidget {
  @override
  _BaseBoxState createState() => _BaseBoxState();
}

class _BaseBoxState extends State<BaseBox> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FontBox(),
        ButtonBox(),
        ImageBox(),
        Checkedbox(),
        TextBox(),
        FormBox(),
        IndicatorBox()
      ],
    );
  }
}

class BoxTap extends StatefulWidget {
  BoxTap({Key key, @required this.active}) : super(key: key);
  bool active;
  @override
  _BoxTapState createState() => _BoxTapState();
}

class _BoxTapState extends State<BoxTap> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.active = !widget.active;
        });
      },
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration:
            BoxDecoration(color: widget.active ? Colors.green : Colors.black),
      ),
    );
  }
}

class FontBox extends StatefulWidget {
  @override
  _FontBoxState createState() => _FontBoxState();
}

class _FontBoxState extends State<FontBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("hello world", textAlign: TextAlign.left),
        Text(
          "heool worldfsdf sad asd ads" * 4,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "jdfkdjfk",
          textScaleFactor: 1.5,
        ),
        DefaultTextStyle(
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.red,
              fontSize: 20.0,
            ),
            child: Column(
              children: <Widget>[
                Text("这里是继承的"),
                Text("这里是不继承的",
                    style: TextStyle(inherit: false, color: Colors.blue))
              ],
            )),
        Text.rich(TextSpan(children: [
          TextSpan(text: "home"),
          TextSpan(
            text: "www.baidu.com",
            style: TextStyle(color: Colors.blue),
            // recognizer: _tapRecognizer
          )
        ])),
        Text(
          "这是我的",
          style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              height: 1.2,
              fontFamily: "Courier",
              background: new Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed),
        ),
      ],
    );
  }
}

class ButtonBox extends StatefulWidget {
  @override
  _ButtonBoxState createState() => _ButtonBoxState();
}

class _ButtonBoxState extends State<ButtonBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text("自带阴影和灰色背景"),
          onPressed: () {},
        ),
        FlatButton(
          child: Text("扁平按钮"),
          onPressed: () {},
        ),
        OutlineButton(
          child: Text("有边框的按钮"),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
        RaisedButton(
            elevation: 2.0, //正常状态下阴影
            highlightElevation: 9.0, //按下状态下阴影
            disabledElevation: 10.0, //禁用状态下阴影
            child: Text("自定义按钮"),
            onPressed: () {},
            color: Colors.blue,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)))
      ],
    );
  }
}

class ImageBox extends StatefulWidget {
  @override
  _ImageBoxState createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.network(
          "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
          width: 100.0,
          color: Colors.red,
          colorBlendMode: BlendMode.colorBurn,
          // fit:BoxFit.fill,
          // repeat:ImageRepeat.repeatX
        ),
        Icon(Icons.accessibility)
      ],
    );
  }
}

class Checkedbox extends StatefulWidget {
  @override
  _CheckedboxState createState() => _CheckedboxState();
}

class _CheckedboxState extends State<Checkedbox> {
  bool _switchSelected = true;
  bool _checkboxSelected = null;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected,
          onChanged: (bool flag) {
            setState(() {
              _switchSelected = flag;
            });
          },
        ),
        Checkbox(
          tristate: true,
          value: _checkboxSelected,
          activeColor: Colors.red,
          onChanged: (bool flag) {
            setState(() {
              _checkboxSelected = flag;
            });
          },
        )
      ],
    );
  }
}

class TextBox extends StatefulWidget {
  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  TextEditingController _username = new TextEditingController();
  FocusNode _usernamenode = new FocusNode();
  FocusNode _passwordnode = new FocusNode();
  @override
  void initState() {
    _username.text = "hell word";
    // _username.selection = TextSelection(
    //   baseOffset: 2,
    //   extentOffset: _username.text.length
    // );//选择两个字符以后的所有字符

    // _username.addListener((){
    //   print(_username);
    // });
    _usernamenode.addListener(() {
      print(_usernamenode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          // autofocus: true,
          controller: _username,
          focusNode: _usernamenode,
          decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)),
          onChanged: (v) {
            print(v);
          },
          // import "package:flutter/services.dart";用于textInputForamter
          // inputFormatters:<TextInputFormatter>[

          // ]
        ),
        TextField(
          focusNode: _passwordnode,
          decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              prefixIcon: Icon(Icons.lock)),
          obscureText: true, //是否隐藏文本
        ),
        RaisedButton(
          child: Text("提交"),
          onPressed: () {
            // print(_username);
          },
        ),
        Builder(builder: (ctx) {
          return Column(
            children: <Widget>[
              RaisedButton(
                child: Text("将光标放置密码处"),
                onPressed: () {
                  _usernamenode.unfocus();
                  FocusScope.of(context).requestFocus(_passwordnode);
                },
              ),
              RaisedButton(
                child: Text("隐藏键盘"),
                onPressed: () {
                  _usernamenode.unfocus();
                  _passwordnode.unfocus();
                },
              )
            ],
          );
        })
      ],
    );
  }
}

class FormBox extends StatefulWidget {
  @override
  _FormBoxState createState() => _FormBoxState();
}

class _FormBoxState extends State<FormBox> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey _formkey = new GlobalKey<FormState>();
  bool Radionflag = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        // autovalidate:true,
        key: _formkey,
        child: Column(
          children: <Widget>[
            FormField(
              onSaved: (value) {
                // userinfor.gender(value);
              },
              validator: (value) {
                if (value != null) {
                  Radionflag = true;
                  return null;
                } else {
                  setState(() {
                    Radionflag = false;
                  });
                }
              },
              builder: (field) {
                return Column(
                  children: <Widget>[
                    Radio(
                      groupValue: field.value,
                      value: 1,
                      onChanged: (newvalue) {
                        field.didChange(newvalue);
                      },
                    ),
                    Radio(
                      groupValue: field.value,
                      value: 2,
                      onChanged: (newvalue) {
                        field.didChange(newvalue);
                      },
                    ),
                    Radio(
                      groupValue: field.value,
                      value: 3,
                      onChanged: (newvalue) {
                        field.didChange(newvalue);
                      },
                    ),
                    Offstage(
                      child: Text("单选为必选项"),
                      offstage: Radionflag,
                    )
                  ],
                );
              },
            ),
            TextFormField(
              controller: _username,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入用户名",
                  prefixIcon: Icon(Icons.lock)),
              onSaved: (value) {},
              validator: (value) {
                return value.trim().length > 0 ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock)),
              onSaved: (value) {},
              obscureText: true,
              validator: (value) {
                return value.trim().length > 6 ? null : "密码不能少于六位";
              },
            ),
            RaisedButton(
              child: Text("提交"),
              onPressed: () {
                //此处不能使用form.of(context) context不是根目录的context 这里的context是FormBox
                if ((_formkey.currentState as FormState).validate()) {
                  (_formkey.currentState as FormState).save();
                  // print('$userinfor.name,$userinfor.word,$userinfor.gender');
                }
                ;
              },
            ),
            Builder(
              builder: (ctx) {
                return RaisedButton(
                  child: Text("不同content的按钮"),
                  onPressed: () {
                    Form.of(ctx).validate();
                  },
                );
              },
            )
          ],
        ));
  }
}

class IndicatorBox extends StatefulWidget {
  @override
  _IndicatorBoxState createState() => _IndicatorBoxState();
}

class _IndicatorBoxState extends State<IndicatorBox> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    _animationController = new AnimationController(vsync: this,duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {print(_animationController.value)}));
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LinearProgressIndicator(
          // value:0,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
        LinearProgressIndicator(
          value:0.5,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
        CircularProgressIndicator(
          value: _animationController.value,
          backgroundColor: Colors.green,
           valueColor: ColorTween(begin: Colors.grey, end: Colors.blue).animate(_animationController)
          // strokeWidth: 10,
        ),
        SizedBox(
          width:100.0,
          height:100.0,
          child:CircularProgressIndicator(
              value: _animationController.value,
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue).animate(_animationController)
          )
        )
      ],
    );
  }
}
