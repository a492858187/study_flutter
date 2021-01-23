import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
//import 'package:amap_location/amap_location.dart';
import 'package:permission_handler/permission_handler.dart';//权限

class DeviceMapPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return DeviceMapPageState();
  }

}

class DeviceMapPageState extends State<DeviceMapPage>{

  var deviceInfo;
  //AMapLocation location;

  @override
  void initState() {
    super.initState();
    //_getDeviceInfo();
    _checkPersmission();
  }

  void _getDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if(Platform.isIOS){
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      this.setState(() {
        this.deviceInfo = iosDeviceInfo;
      });
    }else if(Platform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      this.setState(() {
        this.deviceInfo = androidDeviceInfo;
      });
    }

    // await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    //
    // AMapLocation location = await AMapLocationClient.getLocation(true);
    // this.setState(() {
    //   this.location = location;
    // });

    // AMapLocationClient.onLocationUpate.listen((AMapLocation loc){
    //   if(!mounted)return;
    //   setState(() {
    //     print(loc.city);
    //   });
    // });
    //
    // AMapLocationClient.startLocation();
  }

  void _checkPersmission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
    // 申请结果
    PermissionStatus permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.granted) {
      _getDeviceInfo();
    } else {
      print('定位权限申请被拒绝');
      bool isOpened = await PermissionHandler().openAppSettings();//打开应用设置
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("获取设备信息和使用高德地图"),
      ),
      body: Column(
        children: [
          Text(deviceInfo.brand),
          //Text(location.city == null?"定位失败":location.city)
        ],
      )
    );
  }

}