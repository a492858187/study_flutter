import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Storage.dart';

class SharedPreferencesPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SharedPreferencesPageState();
  }

}

class SharedPreferencesPageState extends State<SharedPreferencesPage>{

  @override
  void initState() {
    super.initState();
  }

  _saveData() async {
    Storage.setString("username","张三");
    Storage.setString("age","20");
  }

  _getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print(sp.getString("username"));
    print(sp.getString("age"));
  }

  _removeData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print(sp.remove("age"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("本地存储"),
      ),
      body: Column(
        children: [
          RaisedButton(
            child: Text("保存数据"),
            onPressed: _saveData
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text("获取数据"),
            onPressed: _getData
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text("删除数据"),
            onPressed: _removeData
          ),
        ],
      )
    );
  }

}