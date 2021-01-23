import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return DemoPageState();
  }

}

class DemoPageState extends State<DemoPage>{

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("条形码和二维码"),
      ),
      body: Column()
    );
  }

}