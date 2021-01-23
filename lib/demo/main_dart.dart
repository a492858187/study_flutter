import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "flutter实战",
      theme: ThemeData(
        primaryColor: Colors.yellow
      ),
      home: HomePage(),
      routes: Constants.routes,
    );
  }

}

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage>{

  List list = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  Future _getData() async{
    await Future.sync(() => {
      list = [
        "下拉刷新和上拉加载",
        "简单的新闻APP",
        "获取设备信息和使用高德地图",
        "调用相机拍照和相册选取",
        "视频播放",
        "检测网络连接，监听网络变化",
        "本地存储",
        "扫描条形码和二维码",
        "版本号及APP更新",
      ]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter实战demo"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
           return Container(
               child:ListTile(
                 title: Text(list[index]),
                 onTap: (){
                   var routeName = Constants.routes.keys.elementAt(index).toString();
                   Navigator.of(context).pushNamed(routeName);
                 },
               ),
             decoration: index == list.length - 1?null:BoxDecoration(
               border:Border.all(width: 0.33, color: Color(0xffe5e5e5))
               //   border: Border(
               //       bottom: BorderSide(
               //           width: 0.33,
               //           color: Color(0xffe5e5e5)
               //       )
               //   )
             ),
           );
        }
      )
    );
  }
}