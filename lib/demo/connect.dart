import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ConnectPageState();
  }

}

class ConnectPageState extends State<ConnectPage>{

  String _state;
  var _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.mobile){
        setState(() {
          _state = "手机网络";
        });
      } else if(event == ConnectivityResult.wifi){
        setState(() {
          _state = "wifi网络";
        });
      } else{
        setState(() {
          _state = "无网络";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("检测网络连接，监听网络变化"),
      ),
      body: Text("$_state")
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

}