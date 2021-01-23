import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }

}

class NewsPageState extends State<NewsPage>{
  var _html = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async{
    var response = await Dio().get("https://www.phonegap100.com/appapi.php?a=getPortalArticle&aid=20");
    var res = json.decode(response.data)["result"];
    //print(res);
    setState(() {
      _html = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("简单新闻App"),
      ),
      body: Column(
        children: [
          Expanded(
           // child: Text("123"),
            child: WebView(
              initialUrl: "https://www.phonegap100.com/newscontent.php?aid=198",
            )
          )
        ],
      )
      // ListView(
      //   children: [
      //     Html(
      //       data: "${_html.length > 0 ? _html[0]["content"] : 1}"
      //     )
      //   ],
      // ),
    );
  }

}