import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class VersionPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return VersionPageState();
  }

}

class VersionPageState extends State<VersionPage>{

  PackageInfo packageInfo;
  int progress;

  @override
  void initState() {
    super.initState();
    _checkPersmission();
  }
  
  void _init() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      this.packageInfo = packageInfo;
    });

    //获取文件存储路径
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var directory = await getExternalStorageDirectory();
    String storageDirectory=directory.path;

    print("tempPath:$tempPath");
    print("appDocDir:$appDocPath");
    print("StorageDirectory:$storageDirectory");

    //下载文件
    await FlutterDownloader.initialize();
    final taskId = await FlutterDownloader.enqueue(
      url: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3363295869,2467511306&fm=26&gp=0.jpg",
      savedDir: storageDirectory,
      showNotification: true,
      openFileFromNotification: true
    );
    //FlutterDownloader.open(taskId: taskId);
    // FlutterDownloader.registerCallback((id, status, progress) {
    //   setState(() {
    //     this.progress = progress;
    //   });
    //   if (taskId == id && status == DownloadTaskStatus.complete) {
    //     OpenFile.open("$storageDirectory/u=3363295869,2467511306&fm=26&gp=0.jpg");
    //   }
    // });
  }

  void _checkPersmission() async {
    // 申请权限
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    // 申请结果
    PermissionStatus permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.granted) {
      _init();
    } else {
      print('定位权限申请被拒绝');
      bool isOpened = await PermissionHandler().openAppSettings();//打开应用设置
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("版本号及APP更新"),
      ),
      body: Column(
        children: [
          Text("appName:${packageInfo?.appName}"),
          Text("packageName:${packageInfo?.packageName}"),
          Text("version:${packageInfo?.version}"),
          Text("buildNumber:${packageInfo?.buildNumber}"),
          Text("$progress")
        ],
      )
    );
  }

}