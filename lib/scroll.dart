import "package:flutter/material.dart";
import "package:english_words/english_words.dart";

class ScrollBox extends StatefulWidget {
  @override
  _ScrollBoxState createState() => _ScrollBoxState();
}

class _ScrollBoxState extends State<ScrollBox> {
  @override
  Widget build(BuildContext context) {
    return    ListViewBox ();
    
    // Scrollbar(
    //     child: SingleChildScrollView(
    //         // scrollDirection: Axis.,
    //         // physics:BouncingScrollPhysics() ,
    //         physics: ClampingScrollPhysics(), //滑动到边界的样式
    //         child: Center(
    //             child: Column(
    //           children: <Widget>[
    //            CustomScrollViewTextRoute(),GridBuilder(), GridExtent(),SingleBox(),ListViewBox(),ListBuildBox(),ListSeparatedBox(),ListSeparatedBox(),GridBox(),PositionTitle();GridCountBox();],
    //         ))));
  }
}

class SingleBox extends StatefulWidget {
  @override
  _SingleBoxState createState() => _SingleBoxState();
}

class _SingleBoxState extends State<SingleBox> {
  String az = "abcdefghijklmnopqrstuvwxyz";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: az
            .split("")
            .map((e) => Text(
                  e,
                  textScaleFactor: 2,
                ))
            .toList(),
      ),
    );
  }
}

class ListViewBox extends StatefulWidget {
  @override
  _ListViewBoxState createState() => _ListViewBoxState();
}

class _ListViewBoxState extends State<ListViewBox> {
  ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = new ScrollController();
    _scrollController.addListener((){
      print(_scrollController.offset);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:GestureDetector(
          child:Text("双击回到头部"),
          onTap: (){
            _scrollController.animateTo(0,duration: Duration(milliseconds: 2),curve: Curves.ease);
          },
        )
      ),
      body:ListView.builder(
        controller: _scrollController,
        itemCount: 30,
        itemBuilder: (BuildContext context,int itemnum){
          return ListTile(title: Text("$itemnum"),);
        },
      )
    );
  }
}

class ListBuildBox extends StatefulWidget {
  @override
  _ListBuildBoxState createState() => _ListBuildBoxState();
}

class _ListBuildBoxState extends State<ListBuildBox> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 100,
      itemBuilder: (BuildContext context, int itemnum) {
        return ListTile(
          title: Text("$itemnum"),
        );
      },
    );
  }
}

class ListSeparatedBox extends StatefulWidget {
  @override
  _ListSeparatedBoxState createState() => _ListSeparatedBoxState();
}

class _ListSeparatedBoxState extends State<ListSeparatedBox> {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(color: Colors.blue); //下划线组件
    Widget divider2 = Divider(color: Colors.green);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 100,
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? divider1 : divider2;
      },
      itemBuilder: (BuildContext context, int itemnum) {
        return ListTile(
          title: Text("$itemnum"),
        );
      },
    );
  }
}

class InfiniteList extends StatefulWidget {
  @override
  _InfiniteListState createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  static const loadingTag = "##loading##"; //表尾标记
  var itemlist = <String>[loadingTag];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveDate();
  }

  void _retrieveDate() {
    Future.delayed(Duration(seconds: 1)).then((res) {
      itemlist.insertAll(itemlist.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {
        itemlist = itemlist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int itemnum) {
        return Divider(height: .0);
      },
      itemCount: itemlist.length,
      itemBuilder: (BuildContext context, int itemnum) {
        if (itemlist[itemnum] == loadingTag) {
          if (itemlist.length < 100) {
            _retrieveDate();
            return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else {
            return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: Text("没有更多了", style: TextStyle(color: Colors.grey)));
          }
        }
        return ListTile(title: Text(itemlist[itemnum]));
      },
    );
  }
}

class PositionTitle extends StatefulWidget {
  @override
  _PositionTitleState createState() => _PositionTitleState();
}

class _PositionTitleState extends State<PositionTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(title: Text("商品列表")),
      Expanded(
          child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: 100,
        itemBuilder: (BuildContext context, int itemnum) {
          return ListTile(title: Text("$itemnum"));
        },
      )),
    ]);
  }
}

class GridBox extends StatefulWidget {
  @override
  _GridBoxState createState() => _GridBoxState();
}

class _GridBoxState extends State<GridBox> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      //SliverGridDelegateWithFixedCrossAxisCount(横轴为固定数量)   SliverGridDelegateWithMaxCrossAxisExtent(横轴的元素为固定的长度)
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, childAspectRatio: 6.0),
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }
}

class GridCountBox extends StatefulWidget {
  @override
  _GridCountBoxState createState() => _GridCountBoxState();
}

class _GridCountBoxState extends State<GridCountBox> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      //==SliverGridDelegateWithFixedCrossAxisCount
      crossAxisCount: 5,
      childAspectRatio: 1.0,
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }
}

class GridExtent extends StatefulWidget {
  @override
  _GridExtentState createState() => _GridExtentState();
}

class _GridExtentState extends State<GridExtent> {
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 150,
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast)
      ],
    );
  }
}

class GridBuilder extends StatefulWidget {
  @override
  _GridBuilderState createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  List<IconData> _icons = [];
  @override
  void initState() {
    _retrieveIcons();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0
      ) ,
      itemBuilder: (BuildContext context,int itemnum){
        if(itemnum == _icons.length-1&&_icons.length<20){
          _retrieveIcons();
        }
        return Icon(_icons[itemnum]);
      },
      itemCount: _icons.length,
    );
  }

  void _retrieveIcons() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}


class CustomScrollViewTextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child:CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned:true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title:Text("demo"),
              background: Icon(Icons.add),

            ),
          ),
          SliverPadding(
            padding:const EdgeInsets.all(8.0),
            sliver:SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
              ),
              delegate:SliverChildBuilderDelegate(
                (BuildContext context,int index){
                  return Container(
                    alignment: Alignment.bottomCenter,
                    color:Colors.cyan[100*(index%9)],
                    child:Text("$index"),
                  );
                },
                childCount: 50,
              ) ,
              
            )
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context,int index){
                return Container(
                  alignment:Alignment.bottomCenter,
                  color:Colors.lightBlue[100 * (index % 9)],
                  child:Text("$index")
                );
              },
              childCount: 50,
            )
          )
        ],
      )
    );
  }
}