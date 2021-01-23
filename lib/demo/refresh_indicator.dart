import 'package:flutter/material.dart';


class RefreshIndicatorPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return RefreshIndicatorPageState();
  }

}

class RefreshIndicatorPageState extends State<RefreshIndicatorPage>{

  List list = new List.empty();
  ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        print("滑到了最底部");
        getMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("下拉刷新和上拉加载"),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          itemCount: list.length + 1,
          itemBuilder: (context,index){
            if(index < list.length) {
              return ListTile(
                title: Text(list[index]),
              );
            }else
              return _getMoreWidget();
          },
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _getMoreWidget(){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "加载中...   ",
              style: TextStyle(
                  fontSize: 16.0
              ),
            ),
            Container(
                width: 16.0,
                height: 16.0,
                child:CircularProgressIndicator(strokeWidth: 1.0)
            )
          ],
        ),
      ),
    );
  }

  Future getData() async{
    await Future.delayed(Duration(seconds: 2),(){
      setState(() {
        list = List.generate(15, (index) => "我是第${index + 1}个数据");
      });
    });
  }

  Future refresh() async{
    await Future.delayed(Duration(seconds: 2),(){
      setState(() {
        list = List.generate(15, (index) => "我是刷新的第${index + 1}个数据");
      });
    });
  }

  Future getMore() async{
    if(!isLoading) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 2), () {
        setState(() {
          list.addAll(List.generate(5, (index) => "我是上拉的第${list.length + index + 1}个数据"));
          _page++;
          isLoading = false;
        });
      });
    }
  }

}