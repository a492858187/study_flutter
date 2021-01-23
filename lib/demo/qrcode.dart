import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrCodePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return QrCodePageState();
  }

}

class QrCodePageState extends State<QrCodePage>{

  String barcode;
  Uint8List bytes = Uint8List(0);

  @override
  void initState() {
    super.initState();
    _checkPersmission();
  }

  void _checkPersmission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.camera]);
    // 申请结果
    PermissionStatus permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (permission == PermissionStatus.granted) {

    } else {
      print('定位权限申请被拒绝');
      bool isOpened = await PermissionHandler().openAppSettings();//打开应用设置
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("条形码和二维码"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.yellow,
                child: Image.memory(bytes),
              ),
              Text("码值为：$barcode"),
              MaterialButton(
                child: Text("扫描"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: scan
              ),
              MaterialButton(
                  child: Text("生成普通二维码"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async{
                    Uint8List result = await scanner.generateBarCode(this.barcode);
                    setState(() {
                      this.bytes = result;
                    });
                  }
              ),
              MaterialButton(
                  child: Text("生成条形码"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async{

                  }
              ),
            ],
          ),
        ),
      )
    );
  }

  Future scan() async{
    try{
      String barCode = await scanner.scan();
      print("这是扫描出来的结果"+barCode);
      setState(() {
        this.barcode = barCode;
        bytes = Uint8List(0);
      });
    }on Exception catch(e){
      if(e.toString() == scanner.CameraAccessDenied){
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      }else{
        setState(() {
          this.barcode = 'Unknown error: $e';
        });
      }
    }
  }
}